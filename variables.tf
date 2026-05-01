variable "vpc_cidr" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "az" {
  description = "Availability zone for resources."
  type        = string
}

variable "public_subnet_cidr" {
  description = "CIDR block for the public subnet."
  type        = string
}

variable "environment" {
  description = "Environment name used for tagging."
  type        = string
}

variable "key_name" {
  description = "EC2 key pair name for SSH access."
  type        = string
}
