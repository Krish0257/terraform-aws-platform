output "release_name" {
  description = "Helm release name"
  value       = helm_release.argo_rollouts.name
}

output "release_namespace" {
  description = "Namespace where Argo Rollouts is installed"
  value       = helm_release.argo_rollouts.namespace
}

output "release_version" {
  description = "Installed Helm chart version"
  value       = helm_release.argo_rollouts.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.argo_rollouts.status
}

output "namespace" {
  description = "Argo Rollouts namespace"
  value       = var.namespace
}