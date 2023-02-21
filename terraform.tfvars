  region = "us-east-1"
  project_name = "GXI"
  vpc_cidr = "10.0.0.0/20"
  
  public_subnet_az1_cidr = "10.0.0.0/24"
  public_subnet_az2_cidr = "10.0.1.0/24"
  public_subnet_az3_cidr = "10.0.2.0/24"

  private_app_subnet_az1_cidr = "10.0.3.0/24"
  private_app_subnet_az2_cidr = "10.0.4.0/24"
  private_app_subnet_az3_cidr = "10.0.5.0/24"

  private_data_subnet_az1_cidr = "10.0.6.0/24"
  private_data_subnet_az2_cidr = "10.0.7.0/24"
  private_data_subnet_az3_cidr = "10.0.8.0/24"

  key-algorithm = "RSA"
  key_name = "GXI-key"
  privatekey-filename = "GXI-key.pem" #key name for local system storage of private key

  ami = "ami-0aa7d40eeae50c9a9"
  instance_type = "t2.micro"
