resource "aws_vpc" "my_vpc_1" {
    cidr_block = var.vpc_cidr
    tags = {
      Name = var.vpc_name
    }
}
