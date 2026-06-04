variable "region" {
  description = "AWS region where resources will be created"
  type        = string
}

variable "route_table_name" {
  description = "Name tag for the route table"
  type        = string
}

variable "internet_gw_name" {
  description = "Name tag for the internet gateway"
  type        = string
}

variable "public_c_subnet_name" {
  description = "Name tag for the public subnet in availability zone C"
  type        = string
}

variable "public_b_subnet_name" {
  description = "Name tag for the public subnet in availability zone B"
  type        = string
}

variable "public_a_subnet_name" {
  description = "Name tag for the public subnet in availability zone A"
  type        = string
}

variable "vpc_name" {
  description = "Name tag for the VPC"
  type        = string
}