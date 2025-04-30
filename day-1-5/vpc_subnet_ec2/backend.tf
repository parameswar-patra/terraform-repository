terraform {
backend "s3" {
    bucket         = "parameswar.shop"  # Name of the S3 bucket where the state will be stored.
    region         =  "us-east-1"
    key            = "path-1/terraform.tfstate" # Path within the bucket where the state will be read/written.
    dynamodb_table = "terraform-state-lock-dynamo" # DynamoDB table used for state locking
    encrypt        = true  # Ensures the state is encrypted at rest in S3.
}
}