locals {
  instances = {
    "cicd-server" = {
      security_group_id = var.cicd_sg_id
      volume_size       = 40
      instance_profile  = var.jenkins_instance_profile_name
    }
    "control-plane" = {
      security_group_id = var.controlplane_sg_id
      volume_size       = 40
      instance_profile  = var.ec2_instance_profile_name
    }
    "worker-node" = {
      security_group_id = var.node_sg_id
      volume_size       = 80
      instance_profile  = var.ec2_instance_profile_name
    }
  }
}
