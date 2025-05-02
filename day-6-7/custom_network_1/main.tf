# VPC
resource "aws_vpc" "my_vpc_1" {
    enable_dns_hostnames = true
    cidr_block = "10.0.0.0/16"
    tags = {
      Name = "my-vpc-1"
    }  
}
# IG and Attach to VPC
resource "aws_internet_gateway" "my_IG_1" {
    vpc_id = aws_vpc.my_vpc_1.id
    tags = {
        Name = "my-IG-1"
    }  
}
# subnet
resource "aws_subnet" "my_subnet_1" {
    vpc_id = aws_vpc.my_vpc_1.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "my-subnet-1"
    }  
}

# route table and edit routes
resource "aws_route_table" "my_RT_1" {
    vpc_id = aws_vpc.my_vpc_1.id
    route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_IG_1.id
  }
    tags = {
        Name = "my-RT-1"
    }         
}
# subnet associations
resource "aws_route_table_association" "RTA" {
    route_table_id = aws_route_table.my_RT_1.id
    subnet_id = aws_subnet.my_subnet_1.id  
}
# security group
resource "aws_security_group" "my_SG_1" {
  name        = "my-SG-1"
  vpc_id      = aws_vpc.my_vpc_1.id

  tags = {
    Name = "my-SG-1"
  }

  ingress {
    description = "Allow HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow MySQL traffic"
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "Allow SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
# key pair
resource "aws_key_pair" "my_key_pair" {
    key_name = "n.virginiakey2"
    public_key = file("C:/Users/param/.ssh/id_ed25519.pub")
}
# ec2
resource "aws_instance" "my_instance_1" {
    ami = "ami-0e449927258d45bc4"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_subnet_1.id
    key_name = aws_key_pair.my_key_pair.key_name
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.my_SG_1.id]
    
    tags = {
      Name = "my-instance-1"
    }
}
