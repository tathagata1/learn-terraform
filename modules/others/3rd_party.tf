module "s3-bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "5.7.0"
}

module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "6.4.0"
}