module "ingress_nginx" {
  source = "../../modules/ingress-nginx"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

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

module "prometheus_grafana" {
  source = "../../modules/prometheus-grafana"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  chart_version = "77.11.0"

  depends_on = [
    module.ingress_nginx
  ]
}

module "argocd" {
  source = "../../modules/argocd"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  chart_version = "8.2.6"

  depends_on = [
    module.prometheus_grafana
  ]
}

module "argo_rollouts" {
  source = "../../modules/argo-rollouts"

  providers = {
    kubernetes = kubernetes
    helm       = helm
  }

  chart_version = "2.40.5"

  depends_on = [
    module.argocd
  ]
}