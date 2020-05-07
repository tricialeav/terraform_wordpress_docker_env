variable "profile" {
  description = "The provider profile to use."
  type        = string
  default     = null
}

variable "key_path" {
  description = "The path to a locally stored SSH keypair to use for the instance."
  type        = string
}