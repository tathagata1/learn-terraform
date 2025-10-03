provider "aws" {
  region = var.region
}

resource "aws_instance" "test_ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type

  tags = merge(
    var.tags,
    {
      Name = var.ec2_name
    }
  )

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_db_instance" "db" {
  allocated_storage   = var.db_allocated_storage
  storage_type        = "gp2"
  engine              = "postgres"
  engine_version      = "17.4"
  instance_class      = "db.t3.micro"
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true

  tags = var.tags

  depends_on = [var.db_password]

  lifecycle {
    create_before_destroy = true
  }

}
