output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"

}

output "vpc_cidr" {
  value       = aws_vpc.main.cidr_block
  description = "The CIDR block of the VPC"
}

output "public_subnet_ids" {
  value = [
    aws_subnet.public_a.id,
    aws_subnet.public_b.id,
    aws_subnet.public_c.id
  ]
  description = "The IDs of the public subnets"
}

output "public_subnet_cidr_block" {
  value = [
    aws_subnet.public_a.cidr_block,
    aws_subnet.public_b.cidr_block,
    aws_subnet.public_c.cidr_block
  ]
  description = "The CIDR blocks of the public subnets"
}

output "public_subnet_availability_zone" {
  value = [
    aws_subnet.public_a.availability_zone,
    aws_subnet.public_b.availability_zone,
    aws_subnet.public_c.availability_zone
  ]
  description = "The availability zone of the public subnet in availability zone A"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "The ID of the internet gateway"
}

output "routing_table_id" {
  value       = aws_route_table.rt.id
  description = "The ID of the route table"
}



