# -------------------------
# VPC MODULE
# -------------------------
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr           = var.vpc_cidr
  environment        = var.environment
  az                 = var.az
  public_subnet_cidr = var.public_subnet_cidr
}

# -------------------------
# SECURITY GROUP MODULE
# -------------------------
module "sg" {
  source = "./modules/sg"

  vpc_id   = module.vpc.vpc_id
  vpc_cidr = module.vpc.vpc_cidr
}

# -------------------------
# IAM ROLES MODULE
# -------------------------
module "iam_roles" {
  source = "./modules/iam_roles"
}

# -------------------------
# EC2 MODULE
# -------------------------
module "ec2" {
  source = "./modules/ec2"

  key_name           = var.key_name
  subnet_id          = module.vpc.public_subnet_id
  cicd_sg_id         = module.sg.cicd_sg_id
  controlplane_sg_id = module.sg.controlplane_sg_id
  node_sg_id         = module.sg.node_sg_id
  
  ec2_instance_profile_name     = module.iam_roles.tf_ec2_instance_profile_name
  jenkins_instance_profile_name = module.iam_roles.tf_jenkins_instance_profile_name
}