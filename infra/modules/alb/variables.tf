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