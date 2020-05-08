module "ec2" {
  source                      = "terraform-aws-modules/ec2-instance/aws"
  version                     = "2.13.0"
  name                        = var.name
  ami                         = var.ami
  instance_type               = var.instance_type
  key_name                    = var.key_name
  associate_public_ip_address = var.associate_public_ip_address
  monitoring                  = var.monitoring
  vpc_security_group_ids      = var.vpc_security_group_ids
  subnet_id                   = var.subnet_id
  user_data                   = var.user_data
  tags                        = var.tags
}