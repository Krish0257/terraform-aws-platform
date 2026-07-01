variable "name_prefix" {
  description = "Resource name prefix"
  type        = string
}

variable "tags" {
  description = "Common tags applied to all IAM resources"

  type = map(string)

  default = {}
}