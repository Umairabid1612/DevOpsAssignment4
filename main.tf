terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./modules/vpc"
}

module "security-group" {
  source = "./modules/security-group"
  vpc_id = module.vpc.vpc_id
}

module "key-pair" {
  source = "./modules/key-pair"
}

module "ec2" {
  source = "./modules/ec2"
  wp_sg = module.security-group.web_security_group_id
  db_sg = module.security-group.db_security_group_id
}

output "web_server_public_ip" {
  value = module.ec2.web_server_public_ip
}

output "db_server_private_ip" {
  value = module.ec2.db_server_private_ip
}
