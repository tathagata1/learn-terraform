terraform {

  backend "s3" {
    bucket         = "env-foldersuat-tf-state-bucket-tatha-20250930"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "env-folders-uat-tf-locks-table"
    encrypt        = true
  }


  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 6.0.0"
    }
  }
}


module "basic_setup" {
  source               = "../../modules/basic_setup"
ec2_type             = "t1.micro"
ec2_name = "${"test_ec2"}_uat"
instance_count       = 2
db_allocated_storage = 10
db_username          = "terraformuser"
db_password          = "YourPassword123!"
region               = "us-east-1"
tags = {
  Owner       = "tatha"
  Environment = "uat"
  Project     = "learn-terraform"
}

ec2_ami = "ami-0c02fb55956c7d316"
}