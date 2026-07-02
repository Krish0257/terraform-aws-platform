###############################################
# Kubernetes
###############################################

output "cluster_name" {
  description = "EKS Cluster Name"
  value       = data.terraform_remote_state.dev.outputs.cluster_name
}

output "cluster_endpoint" {
  description = "EKS Cluster Endpoint"
  value       = data.terraform_remote_state.dev.outputs.cluster_endpoint
}

###############################################
# NGINX Ingress
###############################################

output "ingress_release_name" {
  description = "NGINX Ingress Helm Release"
  value       = module.ingress_nginx.release_name
}

output "ingress_namespace" {
  description = "NGINX Ingress Namespace"
  value       = module.ingress_nginx.namespace
}

###############################################
# Prometheus & Grafana
###############################################

output "monitoring_namespace" {
  description = "Monitoring Namespace"
  value       = module.prometheus_grafana.namespace
}

###############################################
# ArgoCD
###############################################

output "argocd_namespace" {
  description = "ArgoCD Namespace"
  value       = module.argocd.namespace
}

###############################################
# Argo Rollouts
###############################################

output "argo_rollouts_namespace" {
  description = "Argo Rollouts Namespace"
  value       = module.argo_rollouts.namespace
}