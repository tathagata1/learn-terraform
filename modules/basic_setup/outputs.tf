output "ec2_pub_ip_address" {
  description = "The public IP address of the EC2 instance"
  value       = [for instance in aws_instance.test_ec2 : instance.public_ip]
}

output "ec2_priv_ip_address" {
  description = "The private IP address of the EC2 instance"
  value       = [for instance in aws_instance.test_ec2 : instance.private_ip]
}

output "db_address" {
  description = "The IP address of the DB instance"
  value       = aws_db_instance.db.address
}

output "db_port" {
  description = "The IP address of the DB instance"
  value       = aws_db_instance.db.port
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.my-vpc.id
}

output "db_license_model" {
  description = "The license model of the DB instance"
  value       = data.aws_db_instance.db_data_source.license_model
}

output "ec2_instance_detail_1" {
  description = "The ARN of the EC2 instance 1"
  value       = data.aws_instance.ec2_data_source_1.arn

}

output "ec2_instance_detail_2" {
  description = "The ARN of the EC2 instance 2"
  value       = data.aws_instance.ec2_data_source_2.arn

}