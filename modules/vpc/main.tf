resource "aws_vpc" "devops_assignment_4" {
  cidr_block = "10.0.0.0/16"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "devops-assignment-4"
  }
}


resource "aws_subnet" "public_subnet_1" {
  vpc_id                  = aws_vpc.devops_assignment_4.id
  cidr_block              = "10.0.2.0/24"
  availability_zone       = "us-east-1a"  # Specify your desired AZ
  map_public_ip_on_launch = true
  tags = {
    Name = "cs423-devops-public-1"
  }
}

resource "aws_subnet" "private_subnet_1" {
  vpc_id     = aws_vpc.devops_assignment_4.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "us-east-1a"  # Specify your desired AZ
  tags = {
    Name = "cs423-devops-private-1"
  }
}

resource "aws_subnet" "public_subnet_2" {
  vpc_id                  = aws_vpc.devops_assignment_4.id
  cidr_block              = "10.0.4.0/24"
  availability_zone       = "us-east-1b"  # Specify your desired AZ
  map_public_ip_on_launch = true
  tags = {
    Name = "cs423-devops-public-2"
  }
}

resource "aws_subnet" "private_subnet_2" {
  vpc_id     = aws_vpc.devops_assignment_4.id
  cidr_block = "10.0.5.0/24"
  availability_zone = "us-east-1b"  # Specify your desired AZ
  tags = {
    Name = "cs423-devops-private-2"
  }
}


resource "aws_internet_gateway" "vpc_igw" {
  vpc_id = aws_vpc.devops_assignment_4.id
  tags = {
    Name = "cs423-devops-igw"
  }
}

resource "aws_route_table" "public_route_table" {
  vpc_id = aws_vpc.devops_assignment_4.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.vpc_igw.id
  }
  tags = {
    Name = "cs423-devops-public-route-table"
  }
}


resource "aws_route_table_association" "public_subnet_association_1" {
  subnet_id      = aws_subnet.public_subnet_1.id
  route_table_id = aws_route_table.public_route_table.id
}

resource "aws_route_table_association" "public_subnet_association_2" {
  subnet_id      = aws_subnet.public_subnet_2.id
  route_table_id = aws_route_table.public_route_table.id
}


resource "aws_route_table" "private_route_table" {
  vpc_id = aws_vpc.devops_assignment_4.id
  tags = {
    Name = "cs423-devops-private-route-table"
  }
}


resource "aws_route_table_association" "private_subnet_association_1" {
  subnet_id      = aws_subnet.private_subnet_1.id
  route_table_id = aws_route_table.private_route_table.id
}

resource "aws_route_table_association" "private_subnet_association_2" {
  subnet_id      = aws_subnet.private_subnet_2.id
  route_table_id = aws_route_table.private_route_table.id
}

