terraform {

  backend "s3" {
    bucket       = "env-tfvars-tf-state-bucket-tatha-20251020"
    key          = "global/s3/terraform.tfstate"
    region       = "us-east-1"
    encrypt      = true
    use_lockfile = true
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

output "ec2_pub_ip_address" {
  value = module.basic_setup.ec2_pub_ip_address
}

output "ec2_priv_ip_address" {
  value = module.basic_setup.ec2_priv_ip_address
}

output "db_address" {
  value = module.basic_setup.db_address
}

output "db_port" {
  value = module.basic_setup.db_port
}

output "db_license_model" {
  value = module.basic_setup.db_license_model
}

output "ec2_arn_1" {
  value = module.basic_setup.ec2_instance_detail_1
}

output "ec2_arn_2" {
  value = module.basic_setup.ec2_instance_detail_2
}