variable "github_organization" {
  description = "GitHub organization or user name"
  type        = string
}

variable "github_repository" {
  description = "GitHub repository name"
  type        = string
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
  description = "Managed IAM policies to attach to the GitHub Actions role"
  type        = list(string)
  default     = []
}

variable "max_session_duration" {
  description = "Maximum STS session duration in seconds"
  type        = number
  default     = 3600
}

variable "tags" {
  description = "Common resource tags"
  type        = map(string)
  default     = {}
}