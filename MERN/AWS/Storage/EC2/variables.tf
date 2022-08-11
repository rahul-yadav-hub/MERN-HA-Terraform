variable "ami_id" {
  description = "Value of the AMI for the EC2 instance"
  type        = string
}

variable "tag" {
  description = "Value of the tag for the EC2 instance"
  type        = string
}


variable "public_subnet_id" {
  description = "Value of the public subnet id"
  type        = string
}

variable "sg_id" {
  description = "Value of the MongoDB security group id"
  type        = list(string)
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
  description = "Path of script"
  type        = string
}
