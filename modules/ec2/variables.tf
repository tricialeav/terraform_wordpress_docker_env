variable "name" {
  description = "Name to be used on all resources as prefix."
  type        = string
}

variable "ami" {
  description = "ID of AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start."
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance."
  type        = string
}

variable "monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled."
  type        = bool
  default     = false
}

variable "vpc_security_group_ids" {
  description = "A list of security group IDs to associate with."
  type        = list(string)
}

variable "subnet_id" {
  description = "The VPC Subnet ID to launch in."
  type        = string
}

variable "user_data" {
  description = "The user data to provide when launching the instance. Do not pass gzip-compressed data via this argument; see user_data_base64 instead."
  type        = string
  default     = null
}

# variable "create_elasticache_subnet_group" {
#     description = "Controls if elasticache subnet group should be created."
#     type = bool
#     default = false
# }

# variable "create_redshift_subnet_group" {
#     description = "Controls if redshift subnet group should be created."
#     type = bool
#     default = false
# }

variable "tags" {
  description = "A mapping of tags to assign to the resource."
  type        = map(string)
}
