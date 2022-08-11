output "cert_arn" {
  
  description = "ARN of certificate generated from ACM"
  value       = var.count_value ? aws_acm_certificate.cert[0].arn : null
}
