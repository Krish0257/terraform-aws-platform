resource "kubernetes_namespace" "this" {
  count = var.create_namespace ? 1 : 0

  metadata {
    name = var.namespace

    labels = {
      "app.kubernetes.io/name" = "argocd"
    }
  }
}

resource "helm_release" "argocd" {
  name       = var.release_name
  repository = var.helm_repository
  chart      = "argo-cd"
  version    = var.chart_version
  namespace  = var.namespace

  create_namespace = false

  values = [
    for file in var.values_files : file(file)
  ]

  timeout           = var.timeout
  wait              = var.wait
  atomic            = var.atomic
  cleanup_on_fail   = var.cleanup_on_fail
  dependency_update = var.dependency_update

  depends_on = [
    kubernetes_namespace.this
  ]
}