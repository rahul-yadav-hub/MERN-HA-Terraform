output "MONGOSG" {
  description = "ID of Mongo security group"
  value       = aws_security_group.mongo.id
}