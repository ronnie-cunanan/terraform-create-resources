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