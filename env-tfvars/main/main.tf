terraform {

  backend "s3" {
    bucket         = "env-tfvars-tf-state-bucket-tatha-20251020"
    key            = "global/s3/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "env-tfvars-tf-locks-table"
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
ec2_type             = var.ec2_type
ec2_name             = var.ec2_name
instance_count       = var.instance_count
db_allocated_storage = var.db_allocated_storage
db_username          = var.db_username
db_password          = var.db_password
region               = var.region
tags                 = var.tags
ec2_ami              = var.ec2_ami
my_vpc_tag           = var.my_vpc_tag
my_subnet_tag        = var.my_subnet_tag
vpc_cidr_block       = var.vpc_cidr_block
subnet_cidr_block    = var.subnet_cidr_block
}