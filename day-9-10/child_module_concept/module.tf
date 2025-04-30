module "vpc" {
  source = "./modules/vpc"
  vpc_name = "my-vpc-1"
  vpc_cidr = "10.0.0.0/16"
}
module "subnet" {
  source = "./modules/subnet"
  subnet_cidr = "10.0.0.0/24"
  subnet_name = "my-subnet-1"
  availability_zone = "us-east-1a"
  vpc_id = module.vpc.dev # ( value will come from "module/vpc/source/output.tf")
}