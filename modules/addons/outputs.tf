output "addon_names" {
  description = "Names of the installed EKS addons"
  value = [
    for addon in aws_eks_addon.this : addon.addon_name
  ]
}

output "addon_arns" {
  description = "ARNs of the installed EKS addons"
  value = {
    for name, addon in aws_eks_addon.this :
    name => addon.arn
  }
}

output "addon_statuses" {
  description = "Current status of the installed EKS addons"
  value = {
    for name, addon in aws_eks_addon.this :
    name => addon.status
  }
}