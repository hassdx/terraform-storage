data "aws_vpc" "main" {
  filter {
    name   = "tag:Name"
    values = ["cmtr-3v98t79h-vpc"]
  }
}

data "aws_subnets" "public_subnet" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.main.id]
  }

  filter {
    name   = "cidr-block"
    values = ["10.0.1.0/24", "10.0.3.0/24"]
  }
}

data "aws_security_group" "ec2_sg" {
  vpc_id = data.aws_vpc.main.id
  filter {
    name   = "tag:Name"
    values = ["cmtr-3v98t79h-ec2_sg"]
  }
}

data "aws_security_group" "http_sg" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:Name"
    values = ["cmtr-3v98t79h-http_sg"]
  }
}

data "aws_security_group" "lb_sg" {
  vpc_id = data.aws_vpc.main.id

  filter {
    name   = "tag:Name"
    values = ["cmtr-3v98t79h-sglb"]
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

