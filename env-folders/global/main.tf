terraform {

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
}

#prd
resource "aws_s3_bucket" "prd_tf_state" {
  bucket        = "env-folders-prd-tf-state-bucket-tatha-20250930"
  force_destroy = true
}

resource "aws_dynamodb_table" "prd_tf_locks" {
  name         = "env-folders-prd-tf-locks-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}

#uat
resource "aws_s3_bucket" "uat_tf_state" {
  bucket        = "env-folders-uat-tf-state-bucket-tatha-20250930"
  force_destroy = true
}

resource "aws_dynamodb_table" "uat_tf_locks" {
  name         = "env-folders-uat-tf-locks-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}