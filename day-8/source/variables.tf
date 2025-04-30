variable "vpc_cidr" {
    description = "this is vpc cidr block"
    type = string
    default = ""
}
variable "vpc_name" {
  description = "this is vpc name"
  type = string
  default = ""
}
variable "availability_zone" {
    description = "this is subnet AZ"
    type = string
    default = ""
}
variable "subnet_cidr" {
    description = "this is subnet cidr block"
    type = string
    default = ""
}
variable "subnet_name" {
    description = "this is subnet name"
    type = string
    default = ""
}