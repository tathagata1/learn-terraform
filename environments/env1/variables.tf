variable "ec2_type" {
  description = "AMI ID"
  type        = string
}

variable "ec2_name" {
  description = "Name for EC2 instance"
  type        = string
}

variable "s3" {
  description = "value for s3 bucket name"
  type        = string
}

variable "db_allocated_storage" {
  description = "RDS allocated storage in GB"
  type        = number
}

variable "db_username" {
  type      = string
  sensitive = true
}

variable "db_password" {
  type      = string
  sensitive = true
}
variable "region" {
  description = "AWS region"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
}

variable "ec2_ami" {
  description = "AMI ID"
  type        = string
}