variable "vpc_cidr_block" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/22"
}

variable "public_subnet_cidr_blocks" {
  description = "CIDR blocks for the public subnets"
  type        = list(string)
  default     = ["10.0.0.0/25", "10.0.1.0/25"]

  validation {
    condition     = length(var.public_subnet_cidr_blocks) == length(var.availability_zones)
    error_message = "Public subnet CIDR count must match the number of Availability Zones."
  }
}

variable "private_subnet_cidr_blocks" {
  description = "CIDR blocks for the private subnets"
  type        = list(string)
  default     = ["10.0.2.0/25", "10.0.3.0/25"]

  validation {
    condition     = length(var.private_subnet_cidr_blocks) == length(var.availability_zones)
    error_message = "Private subnet CIDR count must match the number of Availability Zones."
  }
}

variable "availability_zones" {
  description = "Availability Zones used for the Multi-AZ deployment"
  type        = list(string)
  default     = ["eu-west-2a", "eu-west-2b"]
}

variable "default_cidr_block" {
  description = "Default CIDR block used for internet-facing traffic"
  type        = string
  default     = "0.0.0.0/0"
}

variable "image_tag" {
  description = "ECR image tag deployed to the ECS service"
  type        = string
  default     = "latest"

  validation {
    condition     = length(trimspace(var.image_tag)) > 0
    error_message = "Image tag must not be empty."
  }
}

variable "ecr_repository_url" {
  description = "URL of the ECR repository containing the application image"
  type        = string
  default     = "606349121896.dkr.ecr.eu-west-2.amazonaws.com/it-tools-fargate"

  validation {
    condition     = length(trimspace(var.ecr_repository_url)) > 0
    error_message = "ECR repository URL must not be empty."
  }
}