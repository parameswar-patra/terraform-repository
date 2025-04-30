# default
provider "aws" {
   profile = "papu"
   region = "us-east-1"  
}

# Primary region provider
provider "aws" {
  alias  = "primary"
  profile = "papu"
  region = "ap-south-east-1"
}

# Secondary region provider
provider "aws" {
  alias  = "secondary"
  profile = "papu"
  region = "ap-south-1"
}