###############################################
# NGINX Ingress Controller
###############################################

module "ingress_nginx" {
  source = "../../modules/ingress-nginx"

  namespace        = "ingress-nginx"
  create_namespace = true

  release_name = "ingress-nginx"

  chart_version = "4.12.3"

  values_files = []

  timeout = 900
  wait    = true

  atomic            = true
  cleanup_on_fail   = true
  dependency_update = true

  tags = var.common_tags
}

###############################################
# Prometheus & Grafana
###############################################
# module "prometheus_grafana" { 
 # source = "../../modules/prometheus-grafana"

#chart_version = "77.11.0"

#  depends_on = [
 #   module.ingress_nginx
 # ]
# }


###############################################
###############################################
# ArgoCD
###############################################

module "argocd" {
  source = "../../modules/argocd"

  chart_version = "8.2.6"

  #depends_on = [
 #   module.prometheus_grafana
  #]
}
###############################################
# Argo Rollouts
###############################################



module "argo_rollouts" {
  source = "../../modules/argo-rollouts"

  chart_version = "2.40.5"

  depends_on = [
    module.argocd
  ]
}