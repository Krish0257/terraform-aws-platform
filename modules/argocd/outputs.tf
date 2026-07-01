output "release_name" {
  description = "Argo CD Helm release name"
  value       = helm_release.argocd.name
}

output "release_namespace" {
  description = "Namespace where Argo CD is installed"
  value       = helm_release.argocd.namespace
}

output "release_version" {
  description = "Installed Argo CD Helm chart version"
  value       = helm_release.argocd.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.argocd.status
}

output "namespace" {
  description = "Argo CD namespace"
  value       = var.namespace
}