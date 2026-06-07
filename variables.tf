variable "region" {
  description = "AWS region for the resources"
  type        = string
}

variable "project_id" {
  description = "project identifier used for tagging"
  type        = string
}

variable "template_name" {
  description = "Name of the launch template"
  type        = string
}


variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}

variable "key_name" {
  description = "Name of the EC2 key pair"
  type        = string
}

variable "instance_profile_name" {
  description = "Name of the IAM instance profile"
  type        = string
}

variable "asg_name" {
  description = "Name of the Auto Scaling Group"
  type        = string
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}

variable "lb_name" {
  description = "Name of the Load Balancer"
  type        = string
}

variable "tg_name" {
  description = "Name of the Target Group"
  type        = string
}

