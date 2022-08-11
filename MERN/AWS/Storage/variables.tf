variable "region" {
  description = "Value of the aws region"
  type        = string
  default     = "ap-south-1"
}

variable "vpc_id" {
  description = "Value of the vpc id"
  type        = string
}

variable "public_subnet_id" {
  description = "Value of the public_subnet_id"
  type        = string
}

variable "tag" {
  description = "Tag all resource with this value"
  type        = string
}


variable "ami_id" {
  description = "Value of the AMI for the instance"
  type        = string
}

variable "instance_type" {
  description = "Value of the instance type for the EC2 instance"
  type        = string

}


variable "key_name" {
  description = "Value of the key name for the EC2 instance"
  type        = string

}

variable "script_path" {
  description = "Value of the user data script for the EC2 instance"
  type        = string

}


