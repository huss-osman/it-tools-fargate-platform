variable "vpc_id" {
  description = "ID of the VPC where the ALB is deployed"
  type        = string
}

variable "public_subnet_ids" {
  description = "IDs of the public subnets used by the ALB"
  type        = list(string)
}

variable "default_cidr_block" {
  description = "CIDR block allowed to access the ALB"
  type        = string
}

variable "app_port" {
  description = "Application port used by the target group"
  type        = number
}

variable "acm_certificate_arn" {
  description = "ARN of the ACM certificate used for HTTPS"
  type        = string
}

variable "health_check_path" {
  description = "Path used by the ALB target group health check"
  type        = string
  default     = "/"

  validation {
    condition     = startswith(var.health_check_path, "/")
    error_message = "Health check path must start with '/'."
  }
}

variable "healthy_threshold" {
  description = "Number of successful health checks before a target is healthy"
  type        = number
  default     = 2

  validation {
    condition     = var.healthy_threshold >= 2 && var.healthy_threshold <= 10
    error_message = "Healthy threshold must be between 2 and 10."
  }
}

variable "unhealthy_threshold" {
  description = "Number of failed health checks before a target is unhealthy"
  type        = number
  default     = 2

  validation {
    condition     = var.unhealthy_threshold >= 2 && var.unhealthy_threshold <= 10
    error_message = "Unhealthy threshold must be between 2 and 10."
  }
}

variable "deregistration_delay" {
  description = "Time in seconds to drain connections from deregistering targets"
  type        = number
  default     = 30

  validation {
    condition     = var.deregistration_delay >= 0 && var.deregistration_delay <= 3600
    error_message = "Deregistration delay must be between 0 and 3600 seconds."
  }
}