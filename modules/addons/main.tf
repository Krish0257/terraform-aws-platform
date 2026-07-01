locals {
  addons = {
    coredns = {
      version = try(var.addon_versions.coredns, null)
    }

    kube-proxy = {
      version = try(var.addon_versions.kube_proxy, null)
    }

    vpc-cni = {
      version = try(var.addon_versions.vpc_cni, null)
    }

    eks-pod-identity-agent = {
      version = try(var.addon_versions.eks_pod_identity_agent, null)
    }
  }
}

resource "aws_eks_addon" "this" {
  for_each = local.addons

  cluster_name  = var.cluster_name
  addon_name    = each.key
  addon_version = each.value.version

  preserve                    = var.preserve
  resolve_conflicts_on_create = var.resolve_conflicts_on_create
  resolve_conflicts_on_update = var.resolve_conflicts_on_update

  tags = merge(
    var.tags,
    {
      Name = "${var.cluster_name}-${each.key}"
    }
  )
}