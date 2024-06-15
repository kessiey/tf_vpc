# Variable: name
variable "name" {
  type        = string
  description = "The name of the VPC."
}

# Variable: cidr
variable "cidr" {
  type        = string
  description = "The CIDR of the VPC."
}

# Variable: public_subnet
variable "public_subnet" {
  type        = string
  description = "The public subnet to create."
}

# Variable: enable_dns_hostnames
variable "enable_dns_hostnames" {
  type        = bool
  description = "Should be true if you want to use private DNS within the VPC."
  default     = true
}

# Variable: enable_dns_support
variable "enable_dns_support" {
  type        = bool
  description = "Should be true if you want to use private DNS within the VPC."
  default     = true
}

# Variable: map_public_ip_on_launch
variable "map_public_ip_on_launch" {
  type        = bool
  description = "Should be false if you do not want to auto-assign public IP on launch."
  default     = true
}
