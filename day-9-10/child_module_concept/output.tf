output "vpc_id" {
  value = module.vpc.dev # ( value will come from "module/vpc/source/output.tf")
}
output "subnet_id" {
    value = module.subnet.test # ( value will come from "module/subnet/source/output.tf")
}