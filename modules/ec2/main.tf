module "instances" {
  for_each = local.instances

  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 4.3"

  name                        = each.key
  ami                         = data.aws_ami.ubuntu.id
  instance_type               = "t3.micro"
  key_name                    = var.key_name
  subnet_id                   = var.subnet_id
  vpc_security_group_ids      = [each.value.security_group_id]
  associate_public_ip_address = true
  iam_instance_profile        = each.value.instance_profile
  user_data                   = each.key == "cicd-server" ? var.cicd_server_user_data : null

  root_block_device = [
    {
      volume_type = "gp3"
      volume_size = each.value.volume_size
    }
  ]
}
