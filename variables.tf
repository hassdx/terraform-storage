variable "region" {
  description = "AWS region for the resources"
  type        = string
}

variable "project_id" {
  description = "project identifier used for tagging"
  type        = string
}

variable "state_bucket" {
  description = "S3 bucket name that stores the remote state"
  type        = string
}

variable "state_key" {
  description = "S3 bucket name that stores the remote state"
  type        = string
}

variable "ami_id" {
  description = "AMI ID for the EC2 instance"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
}