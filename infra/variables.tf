variable "vpc_cidr_block" {
  type    = string
  default = "10.0.0.0/22"
}

variable "public_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.0.0/25", "10.0.1.0/25"]
}

variable "private_subnet_cidr_blocks" {
  type    = list(string)
  default = ["10.0.2.0/25", "10.0.3.0/25"]
}

variable "availability_zones" {
  type    = list(string)
  default = ["eu-west-2a", "eu-west-2b"]
}

variable "default_cidr_block" {
  type    = string
  default = "0.0.0.0/0"
}