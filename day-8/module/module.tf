module "vpc_subnet" {
    source = "../source"
    # source = "your git source where the template exist"
    vpc_name = "my-vpc-1"
    vpc_cidr = "10.0.0.0/16"
    subnet_cidr = "10.0.0.0/24"
    subnet_name = "my-subnet-1"
    availability_zone = "us-east-1a"
}