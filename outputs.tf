# Output: elb_address
output "elb_address" {
  value = aws_elb.web.dns_name
  description = "The DNS name of the ELB."
}

# Output: addresses
output "addresses" {
  value = aws_instance.web[*].public_ip
  description = "The public IP addresses of the web instances."
}

# Output: public_subnet_id
output "public_subnet_id" {
  value = module.vpc_basic.public_subnet_id
  description = "The ID of the public subnet created."
}

