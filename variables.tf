# AWS Region
variable "region" {
  type        = string
  description = "The AWS region."
}

# AWS Key Pair Name
variable "key_name" {
  type        = string
  description = "The AWS key pair to use for resources."
}

# AMIs by Region
variable "ami" {
  type        = map(string)
  description = "A map of AMIs."
  default     = {}
}

# EC2 Instance Type
variable "instance_type" {
  type        = string
  description = "The instance type."
  default     = "t2.micro"
}
