
output "instance_spot_public_ip" {
  
  description = "Public IP address of the EC2 spot instance"
  value       = var.spot_instance ? aws_spot_instance_request.Pritnul_server[*].public_ip : null
}


output "instance_OnDemand_public_ip" {
  
  description = "Public IP address of the EC2 On Demand instance"
  value       = var.spot_instance ? null : aws_instance.Pritnul_server[*].public_ip
}
