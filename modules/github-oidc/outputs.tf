output "oidc_provider_arn" {
  description = "GitHub OIDC provider ARN"
  value       = aws_iam_openid_connect_provider.github.arn
}

output "oidc_provider_url" {
  description = "GitHub OIDC provider URL"
  value       = aws_iam_openid_connect_provider.github.url
}

output "github_actions_role_name" {
  description = "GitHub Actions IAM role name"
  value       = aws_iam_role.github_actions.name
}

output "github_actions_role_arn" {
  description = "GitHub Actions IAM role ARN"
  value       = aws_iam_role.github_actions.arn
}