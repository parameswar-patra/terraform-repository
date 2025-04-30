resource "aws_instance" "my-instance" {
    ami = "ami-02018c46119b25ffe"
    instance_type = "t2.micro"
    availability_zone = "ca-central-1a"
    user_data = file("./userdata.sh")
    tags = {
      Name = "my-ec2"
    }
}
 # after apply complete don't forget to allow http in security group which is attached with this ec2