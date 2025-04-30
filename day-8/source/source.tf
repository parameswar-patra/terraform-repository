resource "aws_vpc" "my_vpc_1" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.vpc_name
    }
}
resource "aws_subnet" "my-subnet" {
    vpc_id = aws_vpc.my_vpc_1.id
    availability_zone = var.availability_zone
    cidr_block =  var.subnet_cidr
    tags = {
        Name = var.subnet_name
    }
}