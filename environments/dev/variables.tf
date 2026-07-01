variable "project_name" {
  description = "Project name."
  type        = string
}

variable "environment" {
  description = "Deployment environment."
  type        = string
}

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
}

variable "nat_gateway" {
  description = "NAT Gateway configuration."

  type = object({
    enabled = bool
    mode    = string
  })
}

variable "enable_dns_support" {
  description = "Enable DNS support."
  type        = bool
  default     = true
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames."
  type        = bool
  default     = true
}

variable "instance_tenancy" {
  description = "VPC instance tenancy."
  type        = string
  default     = "default"
}

variable "common_tags" {
  description = "Common tags applied to all resources."
  type        = map(string)
  default     = {}
}