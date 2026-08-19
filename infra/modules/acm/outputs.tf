output "certificate_arn" {
  description = "ARN of the validated ACM certificate used for HTTPS"
  value       = aws_acm_certificate_validation.main.certificate_arn
}
