#configure aws provider
provider "aws" {
  region = var.region
  access_key = "AKIAXLP4OOEMVFOEIVDP"
  secret_key = "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"
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

