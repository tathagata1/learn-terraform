provider "aws" {
  region = var.region
}

resource "aws_vpc" "my-vpc" {
  cidr_block = var.vpc_cidr_block
  region     = var.region

  tags = merge(
    var.tags,
    {
      Name = var.my_vpc_tag
    }
  )
}

resource "aws_subnet" "my-aws_subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  cidr_block = var.subnet_cidr_block

  tags = merge(
    var.tags,
    {
      Name = var.my_subnet_tag
    }
  )
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my-vpc.id
}

resource "aws_route_table" "public_rt" {
  vpc_id = aws_vpc.my-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}

resource "aws_route_table_association" "public_assoc" {
  subnet_id      = aws_subnet.my-aws_subnet.id
  route_table_id = aws_route_table.public_rt.id
}

resource "aws_security_group" "main" {
  vpc_id = aws_vpc.my-vpc.id

  ingress = [
    {
      description      = ""
      from_port        = 22
      to_port          = 22
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress = [
    {
      description      = ""
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]
}

resource "aws_key_pair" "deployer" {
  key_name   = "aws_key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClfbY3IIS+ffYpEOqUfI/BRETp4AfdQw0FECp1bsJHdX3w0gb/RLMun33FRV4MhrdXlWH5+GhpZp/qlb8ouNTofP3aOiETeS/ANAX+qHK0AJSxHiLlqeDVUokoDXRHKqwV8bDNG1PBLd1iZ0mH5nhkZciL8iscgdP/KyT2Wf/UpoxcdPGnz3EvGFK+yv+T1zmjSuU7HCCOkcPfg5xg3hJztlBKhlrTrGyM/ulPBfVgO2XLAC2EBGj2r/v+F9rkiN1XhmWT02bCjMKCCYuRHG4cQNgcvWAHFyJJSPT1Hzi/USZqWADuzz+tiHGvzuuY253XxU4/gPSaUcKeKzLf0uOJ tatha@Tathagata"
}

resource "aws_instance" "test_ec2" {
  ami                         = var.ec2_ami
  instance_type               = var.ec2_type
  count                       = var.instance_count
  subnet_id                   = aws_subnet.my-aws_subnet.id
  associate_public_ip_address = true
  vpc_security_group_ids      = [aws_security_group.main.id]
  key_name                    = aws_key_pair.deployer.key_name

  tags = merge(
    var.tags,
    {
      Name = var.ec2_name
    }
  )

  lifecycle {
    create_before_destroy = true
  }

  provisioner "file" {
    source      = "C:/Users/tatha/Downloads/test.txt"
    destination = "/tmp/test-file.txt"
  }

  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = "ec2-user"
    private_key = file("C:/Users/tatha/Downloads/aws_key")
    timeout     = "60s"
  }
}

locals {
  postgres_engine         = "postgres"
  postgres_version        = "17.4"
  postgres_instance_class = "db.t3.micro"
  postgres_port           = 5432
  postgres_storage_type   = "gp2"
}

resource "aws_db_instance" "db" {
  allocated_storage   = var.db_allocated_storage
  storage_type        = local.postgres_storage_type
  engine              = local.postgres_engine
  engine_version      = local.postgres_version
  instance_class      = local.postgres_instance_class
  port                = local.postgres_port
  username            = var.db_username
  password            = var.db_password
  skip_final_snapshot = true
  publicly_accessible = true
  region              = var.region

  tags = var.tags

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [aws_vpc.my-vpc]
}


data "aws_db_instance" "db_data_source" {

  depends_on = [aws_db_instance.db]

}

data "aws_instance" "ec2_data_source_1" {

  filter {
    name   = "instance-id"
    values = [aws_instance.test_ec2[0].id]
  }

  depends_on = [aws_instance.test_ec2]

}

data "aws_instance" "ec2_data_source_2" {
  filter {
    name   = "instance-id"
    values = [aws_instance.test_ec2[1].id]
  }

  depends_on = [aws_instance.test_ec2]
}
