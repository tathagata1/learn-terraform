variable "region" {
  description = "value for region"
  type        = string
  default     = "us-east-1"
}

variable "s3" {
  description = "value for s3 bucket name"
  type        = string
  default     = "tf-state-bucket-tatha-20250924"
}

variable "ec2_ami" {
  description = "AMI ID"
  type        = string
  default     = "ami-0c02fb55956c7d316"
}

variable "ec2_name" {
  description = "Name for EC2 instance"
  type        = string
  default     = "test_ec2_instance"
}

variable "ec2_type" {
  description = "AMI ID"
  type        = string
  default     = "t3.micro"
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
  default     = {
    Owner       = "tatha"
    Environment = "dev"
    Project     = "learn-terraform"
  } 
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
  default     = 20
}

variable "db_username" {
  type        = string
  sensitive = true
}

variable "db_password" {
  type        = string
  sensitive   = true
}