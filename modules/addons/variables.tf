variable "cluster_name" {
  description = "EKS cluster name"
  type        = string
}

variable "cluster_version" {
  description = "EKS Kubernetes version"
  type        = string
}

variable "addon_versions" {
  description = "Optional addon version overrides"

  type = object({
    coredns                = optional(string)
    kube_proxy             = optional(string)
    vpc_cni                = optional(string)
    eks_pod_identity_agent = optional(string)
  })

  default = {}
}

variable "resolve_conflicts_on_create" {
  description = "Conflict resolution strategy during addon creation"
  type        = string
  default     = "OVERWRITE"
}

variable "resolve_conflicts_on_update" {
  description = "Conflict resolution strategy during addon updates"
  type        = string
  default     = "OVERWRITE"
}

variable "preserve" {
  description = "Preserve addons when cluster is deleted"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Common tags applied to all addons"
  type        = map(string)
  default     = {}
}