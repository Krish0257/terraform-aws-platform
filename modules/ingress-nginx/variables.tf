variable "namespace" {
  description = "Namespace where NGINX Ingress Controller will be installed"
  type        = string
  default     = "ingress-nginx"
}

variable "create_namespace" {
  description = "Create namespace if it does not exist"
  type        = bool
  default     = true
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "ingress-nginx"
}

variable "helm_repository" {
  description = "NGINX Ingress Helm repository"
  type        = string
  default     = "https://kubernetes.github.io/ingress-nginx"
}

variable "chart_version" {
  description = "Ingress NGINX Helm chart version"
  type        = string
}

variable "values_files" {
  description = "List of Helm values files"
  type        = list(string)
  default     = []
}

variable "timeout" {
  description = "Helm installation timeout in seconds"
  type        = number
  default     = 900
}

variable "wait" {
  description = "Wait for all resources to become ready"
  type        = bool
  default     = true
}

variable "atomic" {
  description = "Rollback automatically if installation fails"
  type        = bool
  default     = true
}

variable "cleanup_on_fail" {
  description = "Cleanup resources if installation fails"
  type        = bool
  default     = true
}

variable "dependency_update" {
  description = "Update Helm dependencies before installation"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Reserved for future use"
  type        = map(string)
  default     = {}
}