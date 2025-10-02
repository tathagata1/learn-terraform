output "ec2_pub_ip_address" {
  description = "The public IP address of the EC2 instance"
  value       = aws_instance.test_ec2.public_ip
}

output "ec2_priv_ip_address" {
  description = "The private IP address of the EC2 instance"
  value       = aws_instance.test_ec2.private_ip
}

output "db_address" {
  description = "The IP address of the DB instance"
  value       = aws_db_instance.db.address
}

output "db_port" {
  description = "The IP address of the DB instance"
  value       = aws_db_instance.db.port
}