variable "namespace" {
  description = "Namespace where kube-prometheus-stack will be installed"
  type        = string
  default     = "monitoring"
}

variable "create_namespace" {
  description = "Create namespace if it does not exist"
  type        = bool
  default     = true
}

variable "release_name" {
  description = "Helm release name"
  type        = string
  default     = "kube-prometheus-stack"
}

variable "helm_repository" {
  description = "Prometheus Community Helm repository"
  type        = string
  default     = "https://prometheus-community.github.io/helm-charts"
}

variable "chart_version" {
  description = "Helm chart version"
  type        = string
}

variable "values_files" {
  description = "List of Helm values files"
  type        = list(string)
  default     = []
}

variable "timeout" {
  description = "Helm installation timeout"
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
  description = "Cleanup resources if release fails"
  type        = bool
  default     = true
}

variable "dependency_update" {
  description = "Update Helm dependencies"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Reserved for future use"
  type        = map(string)
  default     = {}
}