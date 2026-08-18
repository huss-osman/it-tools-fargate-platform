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

  validation {
    condition     = var.app_port >= 1 && var.app_port <= 65535
    error_message = "Application port must be between 1 and 65535."
  }
}

variable "task_cpu" {
  description = "CPU units allocated to the Fargate task"
  type        = number
  default     = 256

  validation {
    condition     = contains([256, 512, 1024], var.task_cpu)
    error_message = "Task CPU must be 256, 512, or 1024 CPU units."
  }
}

variable "task_memory" {
  description = "Memory allocated to the Fargate task in MiB"
  type        = number
  default     = 512

  validation {
    condition = (
      (var.task_cpu == 256 && contains([512, 1024, 2048], var.task_memory)) ||
      (var.task_cpu == 512 && contains([1024, 2048, 3072, 4096], var.task_memory)) ||
      (var.task_cpu == 1024 && contains([2048, 3072, 4096, 5120, 6144, 7168, 8192], var.task_memory))
    )
    error_message = "Task memory must be compatible with the selected Fargate CPU value."
  }
}

variable "desired_count" {
  description = "Number of ECS tasks maintained by the service"
  type        = number
  default     = 1

  validation {
    condition     = var.desired_count >= 1
    error_message = "Desired count must be at least 1."
  }
}

variable "log_retention_days" {
  description = "Number of days CloudWatch retains ECS application logs"
  type        = number
  default     = 7

  validation {
    condition     = contains([1, 3, 5, 7, 14, 30, 60, 90], var.log_retention_days)
    error_message = "Log retention must be a supported CloudWatch retention period."
  }
}

variable "image_tag" {
  description = "Tag of the ECR container image deployed to ECS"
  type        = string
  default     = "latest"

  validation {
    condition     = length(trimspace(var.image_tag)) > 0
    error_message = "Image tag must not be empty."
  }
}