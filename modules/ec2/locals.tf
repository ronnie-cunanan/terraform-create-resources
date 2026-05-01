locals {
  instances = {
    "cicd-server" = {
      security_group_id = var.cicd_sg_id
      volume_size       = 40
    }
    "control-plane" = {
      security_group_id = var.controlplane_sg_id
      volume_size       = 40
    }
    "worker-node" = {
      security_group_id = var.node_sg_id
      volume_size       = 80
    }
  }
}
