provider "aws" {
  region = var.region
}



resource "aws_instance" "test_ec2" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  count         = var.instance_count
  subnet_id     = aws_subnet.my-aws_subnet.id

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
  region = var.region

  tags = var.tags

  depends_on = [var.db_password]

  lifecycle {
    create_before_destroy = true
  }

}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  region = var.region

  tags = merge(
    var.tags,
    {
      Name = var.my_vpc_tag
    }
  )
}

resource "aws_subnet" "my-aws_subnet" {
  vpc_id            = aws_vpc.my-vpc.id
  cidr_block        = var.subnet_cidr_block

  tags = merge(
    var.tags,
    {
      Name = var.my_subnet_tag
    }
  )
}