# -------------------------
# VPC MODULE
# -------------------------
module "vpc" {
  source  = "./modules/vpc"

  vpc_cidr            = var.vpc_cidr
  environment         = var.environment
  /*
  az                  = var.az
  public_subnet_cidr  = var.public_subnet_cidr
  */
}