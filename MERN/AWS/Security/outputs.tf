output "LB_SG_ID" {
  description = "ID of the load balancer security group"
  value       = aws_security_group.MERN-LB-sg.id
}

output "Backend_SG_ID" {
  description = "ID of the backend instance security group"
  value       = aws_security_group.backend-sg.id
}

output "MongoDB_SG_ID" {
  description = "ID of the MongoDB instance security group"
  value       = aws_security_group.mongodb-sg.id
}

output "Bastion_SG_ID" {
  description = "ID of the Bastion instance security group"
  value       = aws_security_group.Bastion-sg.id
}

output "Pritunl_SG_ID" {
  description = "ID of the Pritunl VPN instance security group"
  value       = aws_security_group.pritunl-sg.id
}



