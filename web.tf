# Provider configuration for AWS
provider "aws" {
  region = var.region
}

# Module: VPC Basic
module "vpc_basic" {
  source        = "github.com/kessiey/tf_vpc.git?ref=v0.0.1"
  name          = "web"
  cidr          = "10.0.0.0/16"
  public_subnet = "10.0.1.0/24"
}

# Resource: AWS EC2 Instance for Web
resource "aws_instance" "web" {
  ami                         = var.ami[var.region]
  instance_type               = var.instance_type
  key_name                    = var.key_name
  subnet_id                   = module.vpc_basic.public_subnet_id
  associate_public_ip_address = true
  user_data                   = file("files/web_bootstrap.sh")
  
  vpc_security_group_ids = [
    aws_security_group.web_inbound_sg.id,
  ]
  
  tags = {
    Name = "web-${format("%03d", count.index + 1)}"
  }
  
  count = length(var.instance_ips)
}  # End of AWS EC2 Instance for Web

# Resource: AWS Elastic Load Balancer (ELB)
resource "aws_elb" "web" {
  name            = "web-elb"
  subnets         = [module.vpc_basic.public_subnet_id]
  security_groups = [aws_security_group.web_inbound_sg.id]
  
  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }
  
  instances = aws_instance.web[*].id
}  # End of AWS Elastic Load Balancer (ELB)

# Resource: AWS Security Group for inbound traffic
resource "aws_security_group" "web_inbound_sg" {
  name        = "web_inbound"
  description = "Allow HTTP and ICMP from Anywhere"
  vpc_id      = module.vpc_basic.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}  # End of AWS Security Group for inbound traffic

# Resource: AWS Security Group for web host
resource "aws_security_group" "web_host_sg" {
  name        = "web_host"
  description = "Allow SSH and HTTP to web hosts"
  vpc_id      = module.vpc_basic.vpc_id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [module.vpc_basic.cidr]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 0
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}  # End of AWS Security Group for web host
