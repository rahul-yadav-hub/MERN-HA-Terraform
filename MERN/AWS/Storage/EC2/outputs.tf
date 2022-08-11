

output "instance_private_ip" {

  description = "Private IP address of the secondary2 EC2"
  value       = aws_instance.instance.private_ip
}

output "instance_public_ip" {

  description = "Pubic IP address of the primary EC2"
  value       = aws_instance.instance.public_ip
}
