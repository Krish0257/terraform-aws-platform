output "release_name" {
  description = "Helm release name"
  value       = helm_release.ingress_nginx.name
}

output "release_namespace" {
  description = "Namespace where the NGINX Ingress Controller is installed"
  value       = helm_release.ingress_nginx.namespace
}

output "release_version" {
  description = "Installed Helm chart version"
  value       = helm_release.ingress_nginx.version
}

output "release_status" {
  description = "Status of the Helm release"
  value       = helm_release.ingress_nginx.status
}

output "namespace" {
  description = "Ingress NGINX namespace"
  value       = var.namespace
}