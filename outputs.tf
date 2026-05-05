output "cicd_server_public_ip" {
  description = "Public IP address of cicd-server instance."
  value       = module.ec2.cicd_server_public_ip
}
