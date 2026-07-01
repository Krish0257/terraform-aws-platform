###############################################
# Enterprise Locals
###############################################

locals {

  #################################################
  # Naming
  #################################################

  name_prefix = lower(join("-", [
    var.project_name,
    var.environment
  ]))

  vpc_name                = "${local.name_prefix}-vpc"
  igw_name                = "${local.name_prefix}-igw"
  public_route_table_name = "${local.name_prefix}-public-rt"

  #################################################
  # Common Tags
  #################################################

  common_tags = merge(
    var.common_tags,
    {
      Project     = var.project_name
      Environment = var.environment
      ManagedBy   = "Terraform"
      Terraform   = "true"
    }
  )

  #################################################
  # Public Subnets
  #################################################

  public_subnets = {
    for subnet_name, subnet in var.network.subnets :
    subnet_name => subnet
    if lower(subnet.type) == "public"
  }

  #################################################
  # Private Subnets
  #################################################

  private_subnets = {
    for subnet_name, subnet in var.network.subnets :
    subnet_name => subnet
    if lower(subnet.type) == "private"
  }

  #################################################
  # Availability Zones
  #################################################

  availability_zones = sort(distinct([
    for subnet in values(var.network.subnets) :
    subnet.az
  ]))

  #################################################
  # Enterprise Names
  #################################################

  public_subnet_names = {
    for subnet_name, subnet in local.public_subnets :
    subnet_name => "${local.name_prefix}-${subnet_name}"
  }

  private_subnet_names = {
    for subnet_name, subnet in local.private_subnets :
    subnet_name => "${local.name_prefix}-${subnet_name}"
  }

  #################################################
  # Public Subnet By AZ
  #################################################

  public_subnet_by_az = {
    for subnet_name, subnet in local.public_subnets :
    subnet.az => subnet_name
  }

  #################################################
  # NAT Gateway Placement
  #################################################

  nat_gateways = (
    !var.nat_gateway.enabled
    ? {}
    : lower(var.nat_gateway.mode) == "single"
    ? {
      primary = {
        public_subnet = keys(local.public_subnets)[0]
        az            = values(local.public_subnets)[0].az
      }
    }
    : {
      for subnet_name, subnet in local.public_subnets :
      subnet.az => {
        public_subnet = subnet_name
        az            = subnet.az
      }
    }
  )

  #################################################
  # Private Route Tables
  #################################################

  private_route_tables = (
    !var.nat_gateway.enabled
    ? {}
    : lower(var.nat_gateway.mode) == "single"
    ? {
      private = {
        nat_gateway = "primary"
      }
    }
    : {
      for az in local.availability_zones :
      az => {
        nat_gateway = az
      }
    }
  )

  #################################################
  # Private Route Associations
  #################################################

  private_route_associations = (
    lower(var.nat_gateway.mode) == "single"
    ? {
      for subnet_name, subnet in local.private_subnets :
      subnet_name => {
        route_table = "private"
      }
    }
    : {
      for subnet_name, subnet in local.private_subnets :
      subnet_name => {
        route_table = subnet.az
      }
    }
  )

}