resource "aws_vpc" "my-vpc" {
    cidr_block = var.vpc-cidr
    tags = {
      Name = var.vpc_name
    }
    depends_on = [ aws_instance.my-instance ]
}

resource "aws_subnet" "my-subnet" {
    vpc_id = aws_vpc.my-vpc.id
    cidr_block =  var.subnet-cidr
    availability_zone = var.subnet_AZ

}
resource "aws_instance" "my-instance" {
    ami = var.ami-id
    instance_type = var.instance_type
    availability_zone = var.instance_AZ
    tags = {
      Name = var.instance_name
    }  
}