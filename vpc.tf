# VPC

resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}

# Subnets

resource "aws_subnet" "nat_gateway" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.1.0/24"
}

resource "aws_subnet" "linux" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.2.0/24"
}

resource "aws_subnet" "windows" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.0.3.0/24"
}

# Security Groups

resource "aws_security_group" "linux" {
  name        = "${var.creator}-linux"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "linux" {
  security_group_id = aws_security_group.linux.id
  cidr_ipv4         = var.global_ip_address
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_egress_rule" "linux" {
  security_group_id = aws_security_group.linux.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_security_group" "windows" {
  name        = "${var.creator}-windows"
  description = "Allow RDP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id
}

resource "aws_vpc_security_group_ingress_rule" "windows" {
  security_group_id = aws_security_group.windows.id
  cidr_ipv4         = var.global_ip_address
  from_port         = 3389
  ip_protocol       = "tcp"
  to_port           = 3389
}

resource "aws_vpc_security_group_egress_rule" "windows" {
  security_group_id = aws_security_group.windows.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# Gateways

resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

# EIPs

resource "aws_eip" "linux" {
  instance = aws_instance.linux.id
  domain   = "vpc"
}

resource "aws_eip" "windows" {
  instance = aws_instance.windows.id
  domain   = "vpc"
}

# Route Tables

resource "aws_route_table" "ec2" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

resource "aws_route_table_association" "linux" {
  subnet_id      = aws_subnet.linux.id
  route_table_id = aws_route_table.ec2.id
}

resource "aws_route_table_association" "windows" {
  subnet_id      = aws_subnet.windows.id
  route_table_id = aws_route_table.ec2.id
}
