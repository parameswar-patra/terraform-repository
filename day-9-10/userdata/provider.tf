terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.95.0"
    }
  }
}
provider "aws" {
    profile = "papu"
    region = "ca-central-1" 
}