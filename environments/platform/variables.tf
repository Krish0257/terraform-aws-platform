variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "ap-south-1"
}

variable "cluster_name" {
  description = "EKS Cluster Name"
  type        = string
}

variable "common_tags" {
  description = "Common tags"
  type        = map(string)

  default = {
    ManagedBy = "Terraform"
  }
}