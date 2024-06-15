# Output: public_subnet_id
output "public_subnet_id" {
  value       = aws_subnet.public.id
  description = "The ID of the public subnet created."
}

# Output: vpc_id
output "vpc_id" {
  value       = aws_vpc.tfb.id
  description = "The ID of the VPC created."
}

# Output: cidr
output "cidr" {
  value       = aws_vpc.tfb.cidr_block
  description = "The CIDR block of the VPC created."
}
