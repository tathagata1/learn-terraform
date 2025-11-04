terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
}

#prd
resource "aws_s3_bucket" "tf_state" {
  bucket        = "env-tfvars-tf-state-bucket-tatha-20251020"
  force_destroy = true
  region = "us-east-1"
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "env-tfvars-tf-locks-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"
  region = "us-east-1"

  attribute {
    name = "LockID"
    type = "S"
  }

}