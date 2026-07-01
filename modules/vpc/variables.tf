###############################################
# Project
###############################################

variable "project_name" {
  description = "Project name."
  type        = string

  validation {
    condition     = length(trimspace(var.project_name)) > 0
    error_message = "project_name cannot be empty."
  }
}

variable "aws_region" {
  description = "AWS region."
  type        = string
}

###############################################
# Environment
###############################################

variable "environment" {
  description = "Deployment environment."
  type        = string

  validation {
    condition = contains(
      ["dev", "stage", "prod"],
      lower(var.environment)
    )

    error_message = "environment must be dev, stage or prod."
  }
}

###############################################
# Network
###############################################

variable "network" {
  description = "VPC network configuration."

  type = object({
    vpc_cidr = string

    subnets = map(object({
      cidr          = string
      az            = string
      type          = string
      map_public_ip = bool
    }))
  })

  #############################################
  # Valid VPC CIDR
  #############################################

  validation {
    condition     = can(cidrhost(var.network.vpc_cidr, 0))
    error_message = "Invalid VPC CIDR."
  }

  #############################################
  # At least one subnet
  #############################################

  validation {
    condition     = length(var.network.subnets) > 0
    error_message = "At least one subnet must be defined."
  }

  #############################################
  # Valid subnet CIDRs
  #############################################

  validation {
    condition = alltrue([
      for subnet in values(var.network.subnets) :
      can(cidrhost(subnet.cidr, 0))
    ])

    error_message = "Every subnet CIDR must be valid."
  }

  #############################################
  # Valid subnet type
  #############################################

  validation {
    condition = alltrue([
      for subnet in values(var.network.subnets) :
      contains(
        ["public", "private"],
        lower(subnet.type)
      )
    ])

    error_message = "Subnet type must be public or private."
  }

  #############################################
  # Valid Availability Zone
  #############################################

  validation {
    condition = alltrue([
      for subnet in values(var.network.subnets) :
      startswith(subnet.az, "ap-south-1")
    ])

    error_message = "Subnet AZ must belong to ap-south-1."
  }

  #############################################
  # Public subnet exists
  #############################################

  validation {
    condition = length([
      for subnet in values(var.network.subnets) :
      subnet
      if lower(subnet.type) == "public"
    ]) > 0

    error_message = "At least one public subnet is required."
  }

  #############################################
  # Private subnet exists
  #############################################

  validation {
    condition = length([
      for subnet in values(var.network.subnets) :
      subnet
      if lower(subnet.type) == "private"
    ]) > 0

    error_message = "At least one private subnet is required."
  }
}

###############################################
# NAT Gateway
###############################################

variable "nat_gateway" {
  description = "NAT Gateway configuration."

  type = object({
    enabled = bool
    mode    = string
  })

  validation {
    condition = contains(
      ["single", "per-az"],
      lower(var.nat_gateway.mode)
    )

    error_message = "nat_gateway.mode must be single or per-az."
  }
}

###############################################
# Enable DNS Support
###############################################

variable "enable_dns_support" {
  description = "Enable DNS support."
  type        = bool
  default     = true
}

###############################################
# Enable DNS Hostnames
###############################################

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames."
  type        = bool
  default     = true
}

###############################################
# Instance Tenancy
###############################################

variable "instance_tenancy" {
  description = "VPC instance tenancy."

  type    = string
  default = "default"

  validation {
    condition = contains(
      ["default", "dedicated"],
      var.instance_tenancy
    )

    error_message = "instance_tenancy must be default or dedicated."
  }
}

###############################################
# Common Tags
###############################################

variable "common_tags" {
  description = "Common tags applied to all resources."

  type    = map(string)
  default = {}
}