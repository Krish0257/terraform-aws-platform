variable "namespace" {
  description = "Namespace where Argo CD will be installed"
  type        = string
  default     = "argocd"
}

variable "create_namespace" {
  description = "Create the namespace if it does not exist"
  type        = bool
  default     = true
}

variable "chart_version" {
  description = "Argo CD Helm chart version"
  type        = string
}

variable "helm_repository" {
  description = "Argo CD Helm repository"
  type        = string
  default     = "https://argoproj.github.io/argo-helm"
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "argocd"
}

variable "values_files" {
  description = "List of Helm values files"
  type        = list(string)
  default     = []
}

variable "timeout" {
  description = "Helm release timeout in seconds"
  type        = number
  default     = 900
}

variable "atomic" {
  description = "Rollback automatically if installation fails"
  type        = bool
  default     = true
}

variable "wait" {
  description = "Wait until all resources are ready"
  type        = bool
  default     = true
}

variable "cleanup_on_fail" {
  description = "Cleanup resources if release fails"
  type        = bool
  default     = true
}

variable "dependency_update" {
  description = "Update chart dependencies"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags reserved for future use"
  type        = map(string)
  default     = {}
}