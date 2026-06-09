data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = [var.vpc_name]
  }
}

data "aws_subnet" "public_subnet1" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet1_name]
  }
}

data "aws_subnet" "public_subnet2" {
  filter {
    name   = "tag:Name"
    values = [var.public_subnet2_name]
  }
}

data "aws_security_group" "ssh_sg" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_ssh_name]
  }
}

data "aws_security_group" "lb_sg" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_lb_name]
  }
}

data "aws_security_group" "http_sg" {
  filter {
    name   = "tag:Name"
    values = [var.security_group_http_name]
  }
}

data "aws_ami" "amazon_linux_2023" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["al2023-ami-*-x86_64"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

