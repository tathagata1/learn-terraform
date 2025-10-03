variable "region" {
  description = "value for region"
  type        = string
}

variable "ec2_ami" {
  description = "AMI ID"
  type        = string
}

variable "ec2_name" {
  description = "Name for EC2 instance"
  type        = string
}

variable "ec2_type" {
  description = "AMI ID"
  type        = string
}

variable "tags" {
  description = "Tags for resources"
  type        = map(string)
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