output "vpc_id" {
  value = aws_vpc.my_vpc_1.id
}

output "public_instance_ip" {
  value = aws_instance.my_public_instance_1.public_ip
}