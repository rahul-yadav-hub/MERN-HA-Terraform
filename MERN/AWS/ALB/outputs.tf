output "lb_dns" {
  
  description = "DNS Name of ALB"
  value       = aws_lb.myALB.dns_name
}
output "zone_id" {
  
  description = "zone id of ALB"
  value       = aws_lb.myALB.zone_id
}

output "target_group_arn" {
  
  description = "target group arn"
  value       = aws_lb_target_group.myTG.arn
}