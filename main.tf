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


#create security group
module "security_groups" {
  source = "../Project Modules/security-group"

  vpc_id = module.VPC.vpc_id
}

#create application load balancer
module "application_load_balancer" {
  source = "../Project Modules/ALB"
  project_name = module.VPC.project_name
  vpc_id = module.VPC.vpc_id

  alb_security_group_id = module.security_groups.alb_security_group_id

  public_subnet_az1_id = module.VPC.public_subnet_az1_id
  public_subnet_az2_id = module.VPC.public_subnet_az2_id
  public_subnet_az3_id = module.VPC.public_subnet_az3_id

  public_instance_az1_id = module.EC2.public_instance_az1_id
  public_instance_az2_id = module.EC2.public_instance_az2_id
  public_instance_az3_id = module.EC2.public_instance_az3_id
}

#create target ec2 instance
module "EC2" {
  source = "../Project Modules/EC2"
  ami = var.ami

  instance_type = var.instance_type

  public_subnet_security_group_id = module.security_groups.public_subnet_security_group_id

  public_subnet_az1_id = module.VPC.public_subnet_az1_id
  public_subnet_az2_id = module.VPC.public_subnet_az2_id
  public_subnet_az3_id = module.VPC.public_subnet_az3_id
}