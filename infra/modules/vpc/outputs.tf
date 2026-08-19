output "vpc_id" {
  description = "ID of the VPC created by this module"
  value       = aws_vpc.main.id
}

output "public_subnet_ids" {
  description = "IDs of the public subnets created across Availability Zones"
  value       = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  description = "IDs of the private subnets created across Availability Zones"
  value       = aws_subnet.private[*].id
}
