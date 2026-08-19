output "github_actions_role_arn" {
  description = "ARN of the IAM role assumed by GitHub Actions through OIDC"
  value       = aws_iam_role.github_actions.arn
}

output "ecr_repository_url" {
  description = "URL of the ECR repository used to store application images"
  value       = aws_ecr_repository.app.repository_url
}
