output "alb_dns_name" {
  description = "DNS name of the Application Load Balancer"
  value       = aws_lb.main.dns_name
}

output "alb_zone_id" {
  description = "Canonical hosted zone ID of the Application Load Balancer"
  value       = aws_lb.main.zone_id
}

output "alb_security_group_id" {
  description = "ID of the security group attached to the Application Load Balancer"
  value       = aws_security_group.alb.id
}

output "target_group_arn" {
  description = "ARN of the target group used by the ECS service"
  value       = aws_lb_target_group.app.arn
}