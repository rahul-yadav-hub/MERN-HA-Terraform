variable "ami_id" {
  description = "Value of the AMI for the EC2 instance"
  type        = string
}

variable "instance_type" {
  description = "Value of the instance type for the EC2 instance"
  type        = string
  default     = "t3a.micro"
}

variable "key_name" {
  description = "Value of the key name for the EC2 instance"
  type        = string
  default     = "rahul_ec2"
}

variable "iam_role_name" {
  description = "Value of the key name for the EC2 instance"
  type        = string
}
variable "backend_sg" {
  description = "Value of the sg id for backend instance"
  type        = list(string)
}

variable "subnets" {
  description = "Value of the Subnet ids for launch conf"
  type        = list(string)
}

variable "MONGODB_DEV_URI" {
  description = "Value of the mongodb url"
  type        = string
}

variable "PORT" {
  description = "Value of the application port"
  type        = string
}

variable "spot_instance" {
  description = "Boolean value to use spot instancesor not"
  default     = false
}
variable "target_value_avg_cpu" {
  description = "Target value for Avg CPU Utilization for Scaling "
  type        = string
  default = "50.0"
}

variable "min_capacity_asg" {
  description = "Value of the minimum number of instance in ASG"
  type        = string
  default     = "1"
}
variable "max_capacity_asg" {
  description = "Value of the maximum number of instance in ASG"
  type        = string
  default     = "2"
}
variable "grace_period" {
  description = "Value of the ASG Grace period"
  type        = string
  default     = "400"
}
variable "cooldown_period" {
  description = "Value of the ASG cooldon period"
  type        = string
  default     = "120"
}
variable "desired_capacity_asg" {
  description = "Value of the desired number of instance in ASG"
  type        = string
  default     = "1"
}
variable "tag" {
  description = "Value of the tag for the EC2 instance"
  type        = string
  default     = "Rahul-tf-PritunlVPN"
}
variable "target_group_arn" {
  description = "Value of the target group arn"
  type        = string
}
