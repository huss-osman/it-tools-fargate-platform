output "cluster_name" {
  description = "Name of the ECS cluster"
  value       = aws_ecs_cluster.main.name
}

output "service_name" {
  description = "Name of the ECS service running the application"
  value       = aws_ecs_service.app.name
}

output "ecs_security_group_id" {
  description = "ID of the security group attached to the ECS tasks"
  value       = aws_security_group.ecs.id
}

output "task_definition_arn" {
  description = "ARN of the ECS task definition"
  value       = aws_ecs_task_definition.app.arn
}