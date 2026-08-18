variable "vpc_id" {
  description = "ID of the VPC where the ECS service is deployed"
  type        = string
}

variable "private_subnet_ids" {
  description = "IDs of the private subnets used by ECS tasks"
  type        = list(string)
}

variable "alb_security_group_id" {
  description = "Security group ID of the Application Load Balancer"
  type        = string
}

variable "target_group_arn" {
  description = "ARN of the ALB target group used by the ECS service"
  type        = string
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository containing the application image"
  type        = string
}

variable "app_port" {
  description = "Port exposed by the application container"
  type        = number
  default     = 8080
}

variable "task_cpu" {
  description = "CPU units allocated to the Fargate task"
  type        = number
  default     = 256
}

variable "task_memory" {
  description = "Memory allocated to the Fargate task in MiB"
  type        = number
  default     = 512
}