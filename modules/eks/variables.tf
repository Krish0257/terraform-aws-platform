variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "Kubernetes version"
  type        = string
  default     = "1.34"
}

variable "vpc_id" {
  description = "VPC ID where EKS will be deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "Private subnet IDs for EKS control plane and managed node groups"
  type        = list(string)
}

variable "cluster_role_arn" {
  description = "IAM role ARN for the EKS control plane"
  type        = string
}

variable "node_role_arn" {
  description = "IAM role ARN for the managed node group"
  type        = string
}

variable "endpoint_private_access" {
  description = "Enable private endpoint access"
  type        = bool
  default     = true
}

variable "endpoint_public_access" {
  description = "Enable public endpoint access"
  type        = bool
  default     = true
}

variable "public_access_cidrs" {
  description = "CIDRs allowed to access the EKS API endpoint"
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

variable "node_group_name" {
  description = "Managed node group name"
  type        = string
  default     = "default"
}

variable "instance_types" {
  description = "EC2 instance types for worker nodes"
  type        = list(string)
  default     = ["t3.small"]
}

variable "capacity_type" {
  description = "Node capacity type (ON_DEMAND or SPOT)"
  type        = string
  default     = "ON_DEMAND"
}

variable "disk_size" {
  description = "Worker node root volume size (GiB)"
  type        = number
  default     = 30
}

variable "desired_size" {
  description = "Desired number of worker nodes"
  type        = number
  default     = 2
}

variable "min_size" {
  description = "Minimum number of worker nodes"
  type        = number
  default     = 2
}

variable "max_size" {
  description = "Maximum number of worker nodes"
  type        = number
  default     = 4
}

variable "labels" {
  description = "Labels applied to worker nodes"
  type        = map(string)
  default     = {}
}

variable "taints" {
  description = "Optional taints for managed node group"

  type = list(object({
    key    = string
    value  = string
    effect = string
  }))

  default = []
}

variable "tags" {
  description = "Common tags applied to EKS resources"
  type        = map(string)
  default     = {}
}