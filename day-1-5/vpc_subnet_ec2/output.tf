output "public_ip" {
    value = aws_instance.my-instance.public_ip 
    # sensitive = false (default)
}
output "private_ip" {
    value = aws_instance.my-instance.private_ip
    sensitive = true
}