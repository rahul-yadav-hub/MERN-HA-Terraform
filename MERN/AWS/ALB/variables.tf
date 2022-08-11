
variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}


variable "tag" {
  description = "Value of the tag for the EC2 instance"
  type        = string
  default     = "Rahul-tf-PritunlVPN"
}

variable "PORT" {
  description = "Value of the application port"
  type        = string
}


variable "lb_sg" {
  description = "Value of the sg id for ALB"
  type        = list(string)
}

variable "pub_subnets" {
  description = "Value of the public subnets for ALB"
  type        = list(string)
}

variable "cert_arn" {
  description = "Value of domain certificate arn for ALB"
  type        = string
}



