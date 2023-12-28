data "aws_key_pair" "assignment4_key_data" {
  key_name = "cs423-assignment4-key"
}

data "aws_vpc" "devops_assignment_4" {
  tags = {
    Name = "devops-assignment-4"
  }
}

data "aws_subnet" "public_subnet_1" {
  vpc_id = data.aws_vpc.devops_assignment_4.id
  tags = {
    Name = "cs423-devops-public-1"
  }
}

data "aws_subnet" "private_subnet_1" {
  vpc_id = data.aws_vpc.devops_assignment_4.id
  tags = {
    Name = "cs423-devops-private-1"
  }
}

data "template_file" "wordpress" {
  template = file("${path.module}/wordpress_server_user_data.sh")

  vars = {
    db_instance_ip = aws_instance.db_server.private_ip
  }
}

resource "aws_instance" "web_server" {
  ami                    = "ami-0c7217cdde317cfec"  # Latest Ubuntu AMI
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.assignment4_key_data.key_name
  subnet_id              = data.aws_subnet.public_subnet_1.id
  associate_public_ip_address = true

  user_data = data.template_file.wordpress.rendered
  vpc_security_group_ids = [var.wp_sg]
  tags = {
    Name = "Assignment4-EC2-1"
  }
}

resource "aws_instance" "db_server" {
  ami                    = "ami-0c7217cdde317cfec"
  instance_type          = "t2.micro"
  key_name               = data.aws_key_pair.assignment4_key_data.key_name
  subnet_id              = data.aws_subnet.private_subnet_1.id

  user_data = file("${path.module}/db_server_user_data.sh")
  vpc_security_group_ids = [var.db_sg]
  tags = {
    Name = "Assignment4-EC2-2"
  }
}

