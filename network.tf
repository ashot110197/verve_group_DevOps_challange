resource "aws_vpc" "vpc" {
  cidr_block              = var.cidr_vpc
  enable_dns_support      = true
  enable_dns_hostnames    = true
  tags = {
    "Environment"         = var.environment_tag
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id                  = aws_vpc.vpc.id
  tags = {
    "Environment"         = var.environment_tag
  }
}

resource "aws_subnet" "subnet_public" {
  vpc_id                  = aws_vpc.vpc.id
  cidr_block              = var.cidr_subnet
  map_public_ip_on_launch = "true"
  availability_zone       = var.availability_zone
  tags = {
    "Environment"         = var.environment_tag
  }
}

resource "aws_route_table" "rtb_public" {
  vpc_id = aws_vpc.vpc.id

  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    "Environment" = var.environment_tag
  }
}

resource "aws_route_table_association" "subnet_public" {
  subnet_id      = "aws_subnet.subnet_public.id"
  route_table_id = aws_route_table.rtb_public.id
}

resource "aws_security_group" "web_app_sg" {
  name = "web_app_sg"
  vpc_id = aws_vpc.vpc.id

  # HTTP access drom the VPC
  ingress {
      from_port   = 80
      to_port     = 80
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }
  # SSH access from the VPC
  ingress {
      from_port   = 22
      to_port     = 22
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    "Environment" = var.environment_tag
  }
}