# Cria a VPC
resource "aws_vpc" "my_vpc" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "my_vpc"
  }
}

# Cria a sub-rede pública
resource "aws_subnet" "public_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "public_subnet"
  }
}

# Cria a sub-rede privada
resource "aws_subnet" "private_subnet" {
  vpc_id     = aws_vpc.my_vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "us-west-2b"

  tags = {
    Name = "private_subnet"
  }
}

# sub-rede pública - acesso SSH e HTTP
resource "aws_security_group" "public_security_group" {
  name_prefix = "public_sg_"
  vpc_id      = aws_vpc.my_vpc.id

  ingress {
    from_port = 22
    to_port   = 22
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "public_security_group"
  }
}

output "public_subnet_ids" {
  value = aws_subnet.public_subnet.id
}

output "private_subnet_ids" {
  value = aws_subnet.private_subnet.id
}

