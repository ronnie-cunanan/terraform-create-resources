output "instance_ids" {
  description = "Instance IDs keyed by instance name."
  value = {
    for name, instance in module.instances : name => instance.id
  }
}

output "instance_public_ips" {
  description = "Public IPs keyed by instance name."
  value = {
    for name, instance in module.instances : name => instance.public_ip
  }
}

output "cicd_server_public_ip" {
  description = "Public IP address of cicd-server."
  value       = module.instances["cicd-server"].public_ip
}
