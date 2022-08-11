variable "region" {
  description = "Value of the aws region"
  type        = string
  default     = "ap-south-1"
}

variable "subdomain_name" {
  description = "Value of the subdomain"
  type        = string
  default     = "rahultf.squareops.co.in"
}

variable "spot_instance" {
  description = "Boolean value to use spot instancesor not"
  default     = true
}

variable "hosted_zone_name" {
  description = "Value of the tag for the EC2 instance"
  type        = string
  default     = "squareops.co.in"
}
variable "vpc_name" {
  description = "Value of the vpc name"
  type        = string
  default     = "Custom-VPC"
}

variable "cidr_block_vpc" {
  description = "Value of the CIDR Block in VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "tag_name" {
  description = "Tag all resource with this value"
  type        = string
  default     = "Rahul-tf"
}

variable "public_subnet_count" {
  description = "Value of the no. public subnet to create"
  type = number
}

variable "private_subnet_count" {
  description = "Value of the no. private subnet to create"
  type = number
}

variable "ami_id_st" {
  description = "Value of the AMI for the Mongo DB EC2 instance"
  type        = string
  default     = "ami-05ba3a39a75be1ec4"
}

variable "instance_type_st" {
  description = "Value of the instance type for the MongoDB EC2 instance"
  type        = string
  default     = "t3a.micro"
}

variable "instance_type_asg" {
  description = "Value of the instance type for the ASG EC2 instance"
  type        = string
  default     = "t3a.micro"
}

variable "key_name" {
  description = "Value of the key name for the EC2 instance"
  type        = string
  default     = "rahul_ec2"
}

variable "ami_id_asg" {
  description = "Value of the application AMI for the EC2 instance"
  type        = string
}

variable "iam_role_name" {
  description = "Value of the key name for the EC2 instance"
  type        = string
}

variable "PORT" {
  description = "Value of the application port"
  type        = string
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
variable "key_file_path" {
  description = "Value of the key_file_path for VPN server"
  type        = string
  default     = "../../../rahul_ec2.pem"
}
variable "record_type" {
  description = "Value of the Record type for route53"
  type        = string
  default     = "A"
}
variable "repo_url" {
  description = "Value of the repo URL of react app"
  type        = string
}

variable "github_access_token" {
  description = "Value of the github access token"
  type        = string
}

variable "branch_name" {
  description = "Value of the repo branch to deploy to Amplify"
  type        = string
  default     = "master"
}

variable "subdomain_name_amp" {
  description = "Value of the subdomain name for domain association in Amplify"
  type        = string
}

variable "generate_cert_lb" {
  description = "Boolean value to generate certificate using ACM for ALB"
  type = bool
}
variable "lb_cert_arn" {
  description = "value ALB HTTPS cert arn"
  type        = string
}

variable "generate_cert_amplify" {
  description = "Boolean value to generate certificate using ACM for Amplify"
  type = bool
}

variable "create_record_for_lb" {
  description = "Boolean value to create route53 record for ALB DNS"
  type = bool
}
variable "backend_url" {
  description = "Value of backend URL"
  type = string
}

variable "subdomain_name_amp_acm" {
  description = "Value of the subdomain name (FQDN) for domain association in Amplify"
  type        = string
}


variable "ami_id_DB" {
  description = "Value of the AMI for the instance"
  type        = string
}

variable "instance_type_DB" {
  description = "Value of the instance type for the EC2 instance"
  type        = string

}


variable "script_path_DB" {
  description = "Value of the user data script for the EC2 instance"
  type        = string

}