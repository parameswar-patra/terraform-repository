# VPC
resource "aws_vpc" "my_vpc_1" {
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
# public subnets
resource "aws_subnet" "my_public_subnet_1" {
    vpc_id = aws_vpc.my_vpc_1.id
    availability_zone = "us-east-1a"
    cidr_block = "10.0.0.0/24"
    tags = {
        Name = "my-public-subnet-1"
    }  
}
resource "aws_subnet" "my_public_subnet_2" {
    vpc_id = aws_vpc.my_vpc_1.id
    availability_zone = "us-east-1b"
    cidr_block = "10.0.1.0/24"
    tags = {
        Name = "my-public-subnet-2"
    }  
}
# Private Subnets for frontend
resource "aws_subnet" "my_frontend_subnet_1" {
  vpc_id            = aws_vpc.my_vpc_1.id
  cidr_block        = "10.0.2.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-frontend-subnet-1"
  }
}
resource "aws_subnet" "my_frontend_subnet_2" {
  vpc_id            = aws_vpc.my_vpc_1.id
  cidr_block        = "10.0.3.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-frontend-subnet-2"
  }
}
# Private Subnets for backend
resource "aws_subnet" "my_backend_subnet_1" {
  vpc_id            = aws_vpc.my_vpc_1.id
  cidr_block        = "10.0.4.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-backend-subnet-1"
  }
}
resource "aws_subnet" "my_backend_subnet_2" {
  vpc_id            = aws_vpc.my_vpc_1.id
  cidr_block        = "10.0.5.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-backend-subnet-2"
  }
}
# private subnets for RDS
resource "aws_subnet" "my_RDS_subnet_1" {
  vpc_id            = aws_vpc.my_vpc_1.id
  cidr_block        = "10.0.6.0/24"
  availability_zone = "us-east-1a"
  tags = {
    Name = "my-RDS-subnet-1"
  }
}
resource "aws_subnet" "my_RDS_subnet_2" {
  vpc_id            = aws_vpc.my_vpc_1.id
  cidr_block        = "10.0.7.0/24"
  availability_zone = "us-east-1b"
  tags = {
    Name = "my-RDS-subnet-2"
  }
}
# route table and edit routes(for public subnets and internet gateway)
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
# subnet associations( for public subnets)
resource "aws_route_table_association" "public_RTA_1" {
    route_table_id = aws_route_table.my_RT_1.id
    subnet_id = aws_subnet.my_public_subnet_1.id 
}
resource "aws_route_table_association" "public_RTA_2" {
    route_table_id = aws_route_table.my_RT_1.id
    subnet_id = aws_subnet.my_public_subnet_2.id 
}
# Elastic IP for NAT gateway
resource "aws_eip" "my_elastic_IP" {
  # vpc = true ( required for old version terraform)
}
# NAT Gateway
resource "aws_nat_gateway" "my_NAT_gateway_1" {
  allocation_id = aws_eip.my_elastic_IP.id
  subnet_id     = aws_subnet.my_public_subnet_1.id
  tags = {
    Name = "my-NAT-gateway-1"
  }
  depends_on = [aws_internet_gateway.my_IG_1]
}
# route table (for private subnets)
resource "aws_route_table" "my_RT_2" {
    vpc_id = aws_vpc.my_vpc_1.id
    tags = {
        Name = "my-RT-2"
    }         
}
# edit routes (for private subnets)
resource "aws_route" "private_nat_access" {
  route_table_id         = aws_route_table.my_RT_2.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.my_NAT_gateway_1.id
}
# subnet associations(for private subnets)
resource "aws_route_table_association" "private_RTA_1" {
  subnet_id      = aws_subnet.my_frontend_subnet_1.id
  route_table_id = aws_route_table.my_RT_2.id
}
resource "aws_route_table_association" "private_RTA_2" {
  subnet_id      = aws_subnet.my_frontend_subnet_2.id
  route_table_id = aws_route_table.my_RT_2.id
}
resource "aws_route_table_association" "private_RTA_3" {
  subnet_id      = aws_subnet.my_backend_subnet_1.id
  route_table_id = aws_route_table.my_RT_2.id
}
resource "aws_route_table_association" "private_RTA_4" {
  subnet_id      = aws_subnet.my_backend_subnet_2.id
  route_table_id = aws_route_table.my_RT_2.id
}
resource "aws_route_table_association" "private_RTA_5" {
  subnet_id      = aws_subnet.my_RDS_subnet_1.id
  route_table_id = aws_route_table.my_RT_2.id
}
resource "aws_route_table_association" "private_RTA_6" {
  subnet_id      = aws_subnet.my_RDS_subnet_2.id
  route_table_id = aws_route_table.my_RT_2.id
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

  ingress {
    description = "Allow MySQL traffic"
    from_port   = 3306
    to_port     = 3306
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
# ec2(public)
resource "aws_instance" "my_public_instance_1" {
    ami = "ami-0e449927258d45bc4"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_public_subnet_1.id
    key_name = aws_key_pair.my_key_pair.key_name
    associate_public_ip_address = "true"
    vpc_security_group_ids = [aws_security_group.my_SG_1.id]
    
    tags = {
      Name = "my-public-instance-1"
    }
}
# ec2(private)
resource "aws_instance" "my_frontend_instance_1" {
    ami = "ami-0e449927258d45bc4"
    instance_type = "t2.micro"
    subnet_id = aws_subnet.my_frontend_subnet_1.id
    key_name = aws_key_pair.my_key_pair.key_name
    vpc_security_group_ids = [aws_security_group.my_SG_1.id]
    
    tags = {
      Name = "my-frontend-instance-1"
    }
}
# subnet group
resource "aws_db_subnet_group" "my_RDS_subnet_group" {
  name = "my-rds-subnet-group"
  subnet_ids = [
    aws_subnet.my_RDS_subnet_1.id,
    aws_subnet.my_RDS_subnet_2.id]
  tags = {
    Name = "my-rds-subnet-group"
  }
}