variable "type" {
    description = "this is my instance type"
    type = string
    default = "t2.micro"
}
variable "ami-id" {
    description = "this is my instance AMI-id"
    type = string
    default = "ami-00a929b66ed6e0de6" 
}
variable "name" {
    description = "this is my instance-tag( instance-name)"
    type = string
    default = "myec2" 
}