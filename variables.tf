variable "region" {
  description = "AWS region for the resources"
  type        = string
}

variable "project_id" {
  description = "project identifier used for tagging"
  type        = string
}

variable "vpc_name" {
  description = "Name of the VPC to use"
  type        = string
}

variable "public_subnet_name" {
  description = "Name of the public subnets to use"
  type        = string
}

variable "security_group_name" {
  description = "Name of the security group to use for EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "instance_name" {
  description = "Name tag for the EC2 instance"
  type        = string
}