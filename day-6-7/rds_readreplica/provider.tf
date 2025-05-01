# default/primary region provider
provider "aws" {
   # here no need to declare <alias="primary">
   profile = "papu"
   region = "us-east-1"  #(n.virginia)
}

# Secondary region provider
provider "aws" {
  alias  = "secondary"
  profile = "papu"
  region = "ap-south-1" #(mumbai)
}