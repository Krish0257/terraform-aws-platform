output "addon_names" {
  description = "Installed EKS add-ons."

  value = {
    for name, addon in aws_eks_addon.this :
    name => addon.addon_name
  }
}

output "addon_versions" {
  description = "Installed EKS add-on versions."

  value = {
    for name, addon in aws_eks_addon.this :
    name => addon.addon_version
  }
}