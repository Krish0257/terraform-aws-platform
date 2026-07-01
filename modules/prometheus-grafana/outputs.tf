output "release_name" {
  description = "Helm release name"
  value       = helm_release.kube_prometheus_stack.name
}

output "release_namespace" {
  description = "Namespace where kube-prometheus-stack is installed"
  value       = helm_release.kube_prometheus_stack.namespace
}

output "release_version" {
  description = "Installed Helm chart version"
  value       = helm_release.kube_prometheus_stack.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.kube_prometheus_stack.status
}

output "namespace" {
  description = "Monitoring namespace"
  value       = var.namespace
}