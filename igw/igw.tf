module "vpc" {
  source = "../vpc"
}

# Cria o internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = module.vpc.aws_vpc.my_vpc.id

  tags = {
    Name = "my_igw"
  }
}

# Anexa o internet gateway à sub-rede pública
resource "aws_route_table" "public_route_table" {
  vpc_id = module.vpc.aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public_route_table"
  }
}

resource "aws_route_table_association" "public_association" {
  subnet_id = module.vpc.aws_subnet.public_subnet.id
  route_table_id = aws_route_table.public_route_table.id
}