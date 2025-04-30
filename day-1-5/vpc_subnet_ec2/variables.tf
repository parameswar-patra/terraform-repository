# variables for vpc
variable "vpc-cidr" {
    description = "this is vpc cidr block"
    type = string
    default = ""
}
variable "vpc_name" {
    description = "this is vpc name"
    type = string
    default = ""
}
# variables for instance
variable "instance_type" {
    description = "this is instance type"
    type = string
    default = ""
}
variable "ami-id" {
    description = "this is instance AMI-id"
    type = string
    default = "" 
}
variable "instance_name" {
    description = "this is instance tag(instance name)"
    type = string
    default = "" 
}
variable "instance_AZ" {
    description = "this is instance availability zone"
    type = string
    default = "" 
}
# variables for subnet
variable "subnet-cidr" {
    description = "this is my subnst cidr block"
    type = string
    default = ""  
}
variable "subnet_AZ" {
    description = "this is subnet availability zone"
    type = string
    default = "" 
}