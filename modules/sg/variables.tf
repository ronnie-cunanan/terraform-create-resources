variable "vpc_id" {
  description = "VPC ID where the security group will be created."
  type        = string
}

variable "vpc_cidr" {
  description = "CIDR block of the linked VPC."
  type        = string
}
