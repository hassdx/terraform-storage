resource "aws_vpc" "main" {
  cidr_block = "10.10.0.0/16"

  tags = {
    Name = var.vpc_name
  }
}

resource "aws_subnet" "public_a" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.10.1.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = var.public_a_subnet_name
  }
}

resource "aws_subnet" "public_b" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.10.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = var.public_b_subnet_name
  }
}

resource "aws_subnet" "public_c" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.10.5.0/24"
  availability_zone = "us-east-1c"

  tags = {
    Name = var.public_c_subnet_name
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = var.internet_gw_name
  }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
  tags = {
    Name = var.route_table_name
  }
}