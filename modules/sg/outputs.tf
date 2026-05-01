output "controlplane_sg_id" {
  description = "ID of the control plane security group."
  value       = aws_security_group.tf_controlplane_sg.id
}

output "cicd_sg_id" {
  description = "ID of the CI/CD security group."
  value       = aws_security_group.tf_cicd_sg.id
}

output "node_sg_id" {
  description = "ID of the node security group."
  value       = aws_security_group.tf_node_sg.id
}
