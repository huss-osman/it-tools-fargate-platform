output "vpc_id" {
  description = "ID of the VPC hosting the application infrastructure"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets used by internet-facing resources"
  value       = module.vpc.public_subnet_ids
}

output "private_subnet_ids" {
  description = "IDs of the private subnets used by ECS tasks"
  value       = module.vpc.private_subnet_ids
}
