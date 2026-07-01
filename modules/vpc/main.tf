###############################################
# VPC
###############################################

resource "aws_vpc" "this" {
  cidr_block           = var.network.vpc_cidr
  enable_dns_support   = var.enable_dns_support
  enable_dns_hostnames = var.enable_dns_hostnames
  instance_tenancy     = var.instance_tenancy

  tags = merge(
    local.common_tags,
    {
      Name = local.vpc_name
    }
  )

  lifecycle {
    precondition {
      condition     = length(var.network.subnets) > 0
      error_message = "At least one subnet must be defined."
    }

    precondition {
      condition = (
        !var.nat_gateway.enabled ||
        length(local.public_subnets) > 0
      )

      error_message = "NAT Gateway requires at least one public subnet."
    }

    precondition {
      condition = (
        lower(var.nat_gateway.mode) != "per-az" ||
        length(
          setsubtract(
            toset([
              for subnet in values(local.private_subnets) :
              subnet.az
            ]),
            toset([
              for subnet in values(local.public_subnets) :
              subnet.az
            ])
          )
        ) == 0
      )

      error_message = "per-az NAT mode requires one public subnet in every AZ containing private subnets."
    }
  }
}

###############################################
# Internet Gateway
###############################################

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = local.igw_name
    }
  )
}

###############################################
# Public Subnets
###############################################

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = each.value.map_public_ip

  tags = merge(
    local.common_tags,
    {
      Name = local.public_subnet_names[each.key]
      Type = "public"
    }
  )

  lifecycle {
    precondition {
      condition     = each.value.map_public_ip
      error_message = "Public subnets must have map_public_ip = true."
    }
  }
}

###############################################
# Private Subnets
###############################################

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  vpc_id                  = aws_vpc.this.id
  cidr_block              = each.value.cidr
  availability_zone       = each.value.az
  map_public_ip_on_launch = false

  tags = merge(
    local.common_tags,
    {
      Name = local.private_subnet_names[each.key]
      Type = "private"
    }
  )

  lifecycle {
    precondition {
      condition     = each.value.map_public_ip == false
      error_message = "Private subnets must have map_public_ip = false."
    }
  }
}

###############################################
# Elastic IPs
###############################################

resource "aws_eip" "nat" {
  for_each = local.nat_gateways

  domain = "vpc"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}-eip"
    }
  )

  depends_on = [
    aws_internet_gateway.this
  ]
}

###############################################
# NAT Gateways
###############################################

resource "aws_nat_gateway" "this" {
  for_each = local.nat_gateways

  allocation_id = aws_eip.nat[each.key].allocation_id
  subnet_id     = aws_subnet.public[each.value.public_subnet].id

  connectivity_type = "public"

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}-natgw"
    }
  )

  depends_on = [
    aws_internet_gateway.this
  ]

  lifecycle {
    precondition {
      condition = (
        !var.nat_gateway.enabled ||
        contains(
          keys(local.public_subnets),
          each.value.public_subnet
        )
      )

      error_message = "NAT Gateway must be deployed in a valid public subnet."
    }
  }
}

###############################################
# Public Route Table
###############################################

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = local.public_route_table_name
    }
  )
}

resource "aws_route" "public_default" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.this.id
}

###############################################
# Public Route Table Associations
###############################################

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}

###############################################
# Private Route Tables
###############################################

resource "aws_route_table" "private" {
  for_each = local.private_route_tables

  vpc_id = aws_vpc.this.id

  tags = merge(
    local.common_tags,
    {
      Name = "${local.name_prefix}-${each.key}-private-rt"
    }
  )
}

###############################################
# Private Default Routes
###############################################

resource "aws_route" "private_default" {
  for_each = local.private_route_tables

  route_table_id         = aws_route_table.private[each.key].id
  destination_cidr_block = "0.0.0.0/0"

  nat_gateway_id = (
    var.nat_gateway.enabled
    ? aws_nat_gateway.this[each.value.nat_gateway].id
    : null
  )

  lifecycle {
    precondition {
      condition = (
        !var.nat_gateway.enabled ||
        contains(
          keys(aws_nat_gateway.this),
          each.value.nat_gateway
        )
      )

      error_message = "Referenced NAT Gateway does not exist."
    }
  }
}

###############################################
# Private Route Table Associations
###############################################

resource "aws_route_table_association" "private" {
  for_each = local.private_route_associations

  subnet_id = aws_subnet.private[each.key].id

  route_table_id = aws_route_table.private[
    each.value.route_table
  ].id
}