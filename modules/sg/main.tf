module "sg" {
  source = "terraform-aws-modules/security-group/aws"

  name        = var.name
  description = var.description
  vpc_id      = var.vpc_id

  ingress_cidr_blocks                   = var.ingress_cidr_blocks
  ingress_rules                         = var.ingress_rules
  ingress_with_cidr_blocks              = var.ingress_with_cidr_blocks
  ingress_with_source_security_group_id = var.ingress_with_source_security_group_id
  egress_with_source_security_group_id = var.egress_with_source_security_group_id
  egress_rules = var.egress_rules
}