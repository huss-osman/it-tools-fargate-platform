variable "vpc_cidr_block" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "public_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
}

variable "private_subnet_cidr_blocks" {
  type        = list(string)
  description = "CIDR blocks for the private subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "Availability Zones for the subnets"
}

variable "default_cidr_block" {
  type        = string
  description = "Default CIDR block for internet traffic"
}