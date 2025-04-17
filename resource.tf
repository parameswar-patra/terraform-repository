resource "aws_instance" "myec2" {
    instance_type = var.type
    ami = var.ami-id
tags = {
    Name = var.name
}
}