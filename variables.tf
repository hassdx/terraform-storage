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

variable "public_subnet1_name" {
  description = "Name of the public subnets to use"
  type        = string
}
variable "public_subnet2_name" {
  description = "Name of the public subnets to use"
  type        = string
}

variable "security_group_ssh_name" {
  description = "Name of the security group to use for EC2 instances"
  type        = string
}

variable "security_group_http_name" {
  description = "Name of the security group to use for EC2 instances"
  type        = string
}

variable "security_group_lb_name" {
  description = "Name of the security group to use for EC2 instances"
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "blue_weight" {
  type = number
}

variable "green_weight" {
  type = number
}
