output "public_ip" {
    description = "The public IP address of a newly created public EC2 instance."
    value = var.associate_public_ip_address ? module.ec2.public_ip[0] : null
}