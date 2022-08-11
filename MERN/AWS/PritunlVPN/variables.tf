variable "ami_type" {
  description = "Value of the AMI for the EC2 instance"
  type        = string
  default     = "ami-068cea625a258ab1f"
}

variable "tag" {
  description = "Value of the tag for the EC2 instance"
  type        = string
  default     = "Rahul-tf-PritunlVPN"
}

variable "vpc_id" {
  description = "Value of the VPC ID"
  type        = string
}

variable "public_subnet_id" {
  description = "Value of the public subnet id"
  type        = string
}

variable "pritunl_sg" {
  description = "Value of the MongoDB security group id"
  type        = list(string)
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

variable "key_file_path" {
  description = "Value of the key file path for ssh"
  type        = string
  default     = "../../rahul_ec2.pem"
  #default     = "/Users/RAHUL/Desktop/SquareOps/rahul_ec2.pem"
}

variable "spot_instance" {
  description = "Boolean value to use spot instancesor not"
  default     = false
}
