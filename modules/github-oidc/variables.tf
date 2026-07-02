variable "github_organization" {
  description = "GitHub organization or user name"
  type        = string
}

variable "github_repositories" {
  description = "GitHub repositories allowed to assume the IAM role"
  type        = list(string)
}

variable "role_name" {
  description = "IAM role name for GitHub Actions"
  type        = string
  default     = "github-actions-oidc"
}

variable "branch" {
  description = "Git branch allowed to assume the IAM role"
  type        = string
  default     = "main"
}

variable "managed_policy_arns" {
  description = "List of managed IAM policies to attach"
  type        = list(string)
}

variable "max_session_duration" {
  description = "Maximum GitHub Actions session duration"
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Tags applied to IAM resources"
  type        = map(string)
  default     = {}
}