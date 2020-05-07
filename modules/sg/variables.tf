variable "name" {
  description = "Name to be used on all resources as prefix."
  type        = string
}

variable "description" {
  description = "Description of security group."
  type        = string
}

variable "vpc_id" {
  description = "ID of the VPC where to create security group."
  type        = string
}

variable "ingress_cidr_blocks" {
  description = "List of IPv4 CIDR ranges to use on all ingress rules."
  type        = list(string)
  default     = []
}

variable "ingress_rules" {
  description = "List of ingress rules to create by name."
  type        = list(string)
  default     = []
}

variable "ingress_with_cidr_blocks" {
  description = "List of ingress rules to create where 'cidr_blocks' is used."
  type        = list(map(string))
  default     = []
}

variable "ingress_with_source_security_group_id" {
  description = "List of ingress rules to create where 'source_security_group_id' is used."
  type        = list(map(string))
  default     = []
}