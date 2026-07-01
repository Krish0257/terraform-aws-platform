variable "repository_name" {
  description = "Name of the ECR repository"
  type        = string
}

variable "image_tag_mutability" {
  description = "Image tag mutability setting"
  type        = string
  default     = "IMMUTABLE"

  validation {
    condition = contains([
      "MUTABLE",
      "IMMUTABLE"
    ], var.image_tag_mutability)

    error_message = "image_tag_mutability must be either MUTABLE or IMMUTABLE."
  }
}

variable "scan_on_push" {
  description = "Enable image scanning on push"
  type        = bool
  default     = true
}

variable "encryption_type" {
  description = "ECR encryption type"
  type        = string
  default     = "AES256"

  validation {
    condition = contains([
      "AES256",
      "KMS"
    ], var.encryption_type)

    error_message = "encryption_type must be either AES256 or KMS."
  }
}

variable "kms_key" {
  description = "KMS key ARN for ECR encryption"
  type        = string
  default     = null
}

variable "force_delete" {
  description = "Delete repository even if it contains images"
  type        = bool
  default     = false
}

variable "lifecycle_policy_enabled" {
  description = "Create lifecycle policy"
  type        = bool
  default     = true
}

variable "untagged_image_retention" {
  description = "Number of untagged images to retain"
  type        = number
  default     = 5
}

variable "tagged_image_retention" {
  description = "Number of tagged images to retain"
  type        = number
  default     = 20
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
  default     = {}
}