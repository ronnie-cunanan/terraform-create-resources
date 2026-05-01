output "instance_ids" {
  description = "Instance IDs keyed by instance name."
  value = {
    for name, instance in module.instances : name => instance.id
  }
}
