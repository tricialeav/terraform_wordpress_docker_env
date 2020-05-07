provider "aws" {
  version = "~> 2.0"
  region  = "us-west-2"
  profile = var.profile
}

data "aws_security_group" "default" {
  name   = "default"
  vpc_id = module.vpc.vpc_id
}

resource "aws_key_pair" "instance_key_pair" {
  key_name   = "ec2_sandbox"
  public_key = file(var.key_path)
}

module "vpc" {
  source           = "terraform-aws-modules/vpc/aws"
  version          = "2.33.0"
  name             = "simple_wordpress_bootstrap"
  cidr             = "10.0.0.0/16"
  azs              = ["us-west-2a", "us-west-2b"]
  public_subnets   = ["10.0.0.0/18"]
  private_subnets  = ["10.0.64.0/18"]
  database_subnets = ["10.0.128.0/19", "10.0.160.0/19"]

  create_database_subnet_group = true

  enable_dns_hostnames = false
  enable_dns_support   = false
}

module "bastion_sg" {
  source = "./modules/sg"

  name        = "bastion_sg"
  description = "Bastion Host Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress_cidr_blocks = ["0.0.0.0/0", module.vpc.vpc_cidr_block]
  ingress_rules       = ["http-80-tcp", "https-443-tcp", "ssh-tcp", "all-icmp"]
}

module "bastion" {
  source                 = "./modules/ec2"
  name                   = "bastion_host"
  ami                    = "ami-0d6621c01e8c2de2c"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.instance_key_pair.key_name
  vpc_security_group_ids = [module.bastion_sg.this_security_group_id]
  subnet_id              = module.vpc.public_subnets[0]
  tags = {
    Name = "Bastion Host"
  }
}

module "webhost_sg" {
  source = "./modules/sg"

  name        = "webhost_sg"
  description = "Webhost Security Group"
  vpc_id      = module.vpc.vpc_id

  ingress_with_source_security_group_id = [
    {
      rule                     = "http-80-tcp"
      source_security_group_id = module.bastion_sg.this_security_group_id
    },
    {
      rule                     = "https-443-tcp"
      source_security_group_id = module.bastion_sg.this_security_group_id
    },
    {
      rule                     = "ssh-tcp"
      source_security_group_id = module.bastion_sg.this_security_group_id
    }
  ]
}

module "webhost" {
  source                 = "./modules/ec2"
  name                   = "webhost"
  ami                    = "ami-0d6621c01e8c2de2c"
  instance_type          = "t2.micro"
  key_name               = aws_key_pair.instance_key_pair.key_name
  vpc_security_group_ids = [module.webhost_sg.this_security_group_id]
  subnet_id              = module.vpc.private_subnets[0]
  tags = {
    Name = "Webhost"
  }
}