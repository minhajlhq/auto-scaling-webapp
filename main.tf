module "vpc" {
  source               = "./modules/vpc"
  name_prefix          = var.name_prefix
  vpc_cidr             = var.vpc_cidr
  public_subnet_cidrs  = var.public_subnet_cidrs
  private_subnet_cidrs = var.private_subnet_cidrs
  azs                  = var.azs
}

module "ec2" {
  source            = "./modules/ec2"
  name_prefix       = var.name_prefix
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  alb_sg_id         = module.alb.alb_sg_id
  ami_id            = var.ami_id
  instance_type     = var.instance_type
  key_name          = var.key_name
  target_group_arns = [module.alb.target_group_arn]
}

module "alb" {
  source            = "./modules/alb"
  name_prefix       = var.name_prefix
  vpc_id            = module.vpc.vpc_id
  public_subnet_ids = module.vpc.public_subnet_ids
  s3_bucket         = module.s3.s3_bucket_name
}

module "rds" {
  source             = "./modules/rds"
  name_prefix        = var.name_prefix
  vpc_id             = module.vpc.vpc_id
  private_subnet_ids = module.vpc.private_subnet_ids
  ec2_sg_id          = module.ec2.ec2_sg_id
  username           = var.db_username
  password           = var.db_password
}


module "s3" {
  source      = "./modules/s3"
  name_prefix = var.name_prefix
  expire_days = 30
}