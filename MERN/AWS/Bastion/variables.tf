variable "ami_type" {
  description = "Value of the AMI for the EC2 instance"
  type        = string
  default     = "ami-05ba3a39a75be1ec4"
}

variable "tag_name" {
  description = "Value of the tag for the EC2 instance"
  type        = string
  default     = "Rahul-tf-PritunlVPN"
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

variable "bastion_sg" {
  description = "Value of the MongoDB security group id"
  type        = list(string)
}

variable "public_subnet_id" {
  description = "Value of the private subnet id"
  type        = string
}
