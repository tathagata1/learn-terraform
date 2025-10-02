terraform {

  backend "s3" {
    bucket         = "tf-state-bucket-tatha-20250930"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-locks-table"
    encrypt        = true
    
  }

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}


resource "aws_s3_bucket" "tf_state" {
  bucket        = var.s3
  force_destroy = true
}

resource "aws_dynamodb_table" "tf_locks" {
  name         = "tf-locks-table"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }

}
