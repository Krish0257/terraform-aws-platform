###############################################
# AWS Account
###############################################

output "aws_account_id" {
  description = "AWS Account ID."

  value = data.aws_caller_identity.current.account_id
}

###############################################
# AWS Region
###############################################

output "aws_region" {
  description = "AWS Region."

  value = var.aws_region
}

###############################################
# Availability Zones
###############################################

output "availability_zones" {
  description = "Availability Zones."

  value = local.availability_zones
}

###############################################
# VPC
###############################################

output "vpc_id" {
  description = "VPC ID."

  value = aws_vpc.this.id
}

output "vpc_arn" {
  description = "VPC ARN."

  value = aws_vpc.this.arn
}

output "vpc_cidr" {
  description = "VPC CIDR."

  value = aws_vpc.this.cidr_block
}

output "default_route_table_id" {
  description = "Default Route Table ID."

  value = aws_vpc.this.default_route_table_id
}

output "default_security_group_id" {
  description = "Default Security Group ID."

  value = aws_vpc.this.default_security_group_id
}

###############################################
# Internet Gateway
###############################################

output "internet_gateway_id" {
  description = "Internet Gateway ID."

  value = aws_internet_gateway.this.id
}

###############################################
# Public Subnets
###############################################

output "public_subnet_ids" {
  description = "Public Subnet IDs."

  value = {
    for name, subnet in aws_subnet.public :
    name => subnet.id
  }
}

output "public_subnet_arns" {
  description = "Public Subnet ARNs."

  value = {
    for name, subnet in aws_subnet.public :
    name => subnet.arn
  }
}

output "public_subnet_cidrs" {
  description = "Public Subnet CIDRs."

  value = {
    for name, subnet in local.public_subnets :
    name => subnet.cidr
  }
}

###############################################
# Private Subnets
###############################################

output "private_subnet_ids" {
  description = "Private Subnet IDs."

  value = {
    for name, subnet in aws_subnet.private :
    name => subnet.id
  }
}

output "private_subnet_arns" {
  description = "Private Subnet ARNs."

  value = {
    for name, subnet in aws_subnet.private :
    name => subnet.arn
  }
}

output "private_subnet_cidrs" {
  description = "Private Subnet CIDRs."

  value = {
    for name, subnet in local.private_subnets :
    name => subnet.cidr
  }
}

###############################################
# NAT Gateways
###############################################

output "nat_gateway_ids" {
  description = "NAT Gateway IDs."

  value = {
    for name, nat in aws_nat_gateway.this :
    name => nat.id
  }
}

output "nat_gateway_public_ips" {
  description = "NAT Gateway Public IPs."

  value = {
    for name, eip in aws_eip.nat :
    name => eip.public_ip
  }
}

###############################################
# Route Tables
###############################################

output "public_route_table_id" {
  description = "Public Route Table ID."

  value = aws_route_table.public.id
}

output "private_route_table_ids" {
  description = "Private Route Table IDs."

  value = {
    for name, rt in aws_route_table.private :
    name => rt.id
  }
}