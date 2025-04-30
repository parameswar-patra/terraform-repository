resource "aws_s3_bucket" "my-s3-bucket" {
    bucket = "parameswar.shop"
}
resource "aws_dynamodb_table" "my-dynamodb-table" {
  name = "terraform-state-lock-dynamo"
  hash_key = "LockID"
  read_capacity = 20
  write_capacity = 20
 
  attribute {
    name = "LockID"
    type = "S"
  }
}