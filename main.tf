#configure aws provider
provider "aws" {
  region = var.region
  access_key = ""
  secret_key = ""
}

#create VPC
module "VPC" {
  source = "../Project Modules/VPC"

  region = var.region
  project_name = var.project_name
  vpc_cidr = var.vpc_cidr
  
  public_subnet_az1_cidr = var.public_subnet_az1_cidr
  public_subnet_az2_cidr = var.public_subnet_az2_cidr
  public_subnet_az3_cidr = var.public_subnet_az3_cidr

  private_app_subnet_az1_cidr = var.private_app_subnet_az1_cidr
  private_app_subnet_az2_cidr = var.private_app_subnet_az2_cidr
  private_app_subnet_az3_cidr = var.private_app_subnet_az3_cidr

  private_data_subnet_az1_cidr = var.private_data_subnet_az1_cidr
  private_data_subnet_az2_cidr = var.private_data_subnet_az2_cidr
  private_data_subnet_az3_cidr = var.private_data_subnet_az3_cidr
}

#create nat gateway
module "nat_gateway" {
  source = "../Project Modules/nat-gateway"
  
  vpc_id = module.VPC.vpc_id
  internet_gateway = module.VPC.internet_gateway

  public_subnet_az1_id = module.VPC.public_subnet_az1_id
  public_subnet_az2_id = module.VPC.public_subnet_az2_id
  public_subnet_az3_id = module.VPC.public_subnet_az3_id

  private_app_subnet_az1_id = module.VPC.private_app_subnet_az1_id
  private_app_subnet_az2_id = module.VPC.private_app_subnet_az2_id
  private_app_subnet_az3_id = module.VPC.private_app_subnet_az3_id

  private_data_subnet_az1_id = module.VPC.private_data_subnet_az1_id
  private_data_subnet_az2_id = module.VPC.private_data_subnet_az2_id
  private_data_subnet_az3_id = module.VPC.private_data_subnet_az3_id
}
