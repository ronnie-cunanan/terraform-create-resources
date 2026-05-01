variable "key_name" {
  description = "EC2 key pair name for SSH access."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where instances will be launched."
  type        = string
}

variable "cicd_sg_id" {
  description = "Security group ID for cicd-server."
  type        = string
}

variable "controlplane_sg_id" {
  description = "Security group ID for control-plane."
  type        = string
}

variable "node_sg_id" {
  description = "Security group ID for worker-node."
  type        = string
}
