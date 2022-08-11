// Select terraform provider
terraform {
  required_providers {
    aws = {
      source         =    "hashicorp/aws"
      version        =    "~> 3.27"
    }
  }

  required_version   =    ">= 0.14.9"
}

// Define provider
provider "aws" {
  profile            =    "sqops"
  region             =    var.region
}

// Generate certificate for a subdomain for ALB using ACM
module "acm" {
  count_value        =    var.generate_cert_lb           // Conditional
  source             =    "../AWS/ACM"
  subdomain_name     =    var.generate_cert_lb ? var.subdomain_name : null
  hosted_zone_name   =    var.generate_cert_lb ? var.hosted_zone_name : null
}

// Generate certificate for a subdomain for Amplify Domain Association using ACM
module "acm_amp" {
  count_value        =    var.generate_cert_amplify     // Conditional
  source             =    "../AWS/ACM"
  subdomain_name     =    var.generate_cert_amplify ? var.subdomain_name_amp_acm : null
  hosted_zone_name   =    var.generate_cert_amplify ? var.hosted_zone_name :null
}

// Create Custom VPC with dynamic subnets
module "myVPC" { 
  source                =    "../AWS/Networking/VPC"
  vpc_name              =    "${var.tag_name}-VPC"
  cidr_block_vpc        =    var.cidr_block_vpc
  public_subnet_count   =    var.public_subnet_count
  private_subnet_count  =    var.private_subnet_count
  tag_name              =    "${var.tag_name}-VPC"
}

// Create Security Groups for ALB, VPN Server, MongoDB server & Application
module "mySecurity" { 
  source             =    "../AWS/Security"
  tag                =    "${var.tag_name}-sg"
  vpc_id             =    module.myVPC.VPC_ID  # using the output of vpc module
}


// Create MongoDB Server
module "mySecurityDB" { 
  source             =    "../AWS/Storage/SecurityGroup"
  tag                =    var.tag_name
  vpc_id             =    module.myVPC.VPC_ID
}

module "EC2-Primary" { 
  source              =     "../AWS/Storage/EC2"
  public_subnet_id    =     module.myVPC.Subnet_IDs[0]
  sg_id               =     ["${module.mySecurityDB.MONGOSG}"]
  key_name            =     var.key_name
  ami_id              =     var.ami_id_DB
  instance_type       =     var.instance_type_DB
  tag                 =     "Rahul_Mongo_P"
  script_path         =     var.script_path_DB
}

module "EC2-Secondary1" { 
  source              =     "../AWS/Storage/EC2"
  public_subnet_id    =     module.myVPC.Subnet_IDs[0]
  sg_id               =     ["${module.mySecurityDB.MONGOSG}"]
  key_name            =     var.key_name
  ami_id              =     var.ami_id_DB
  instance_type       =     var.instance_type_DB
  tag                 =     "Rahul_Mongo_S1"
  script_path         =     var.script_path_DB
}

module "EC2-Secondary2" { 
  source              =     "../AWS/Storage/EC2"
  public_subnet_id    =     module.myVPC.Subnet_IDs[0]
  sg_id               =     ["${module.mySecurityDB.MONGOSG}"]
  key_name            =     var.key_name
  ami_id              =     var.ami_id_DB
  instance_type       =     var.instance_type_DB
  tag                 =     "Rahul_Mongo_S2"
  script_path         =     var.script_path_DB
}

resource "null_resource" "get_ip" {
  depends_on = [
    module.EC2-Primary,
    module.EC2-Secondary1,
    module.EC2-Secondary2
  ]
  provisioner "local-exec" {
    command = "sed -i 's/primary_public_ip/'${module.EC2-Primary.instance_public_ip}'/' ../AWS/Storage/ansible.yml"
  }
  provisioner "local-exec" {
    command = "sed -i 's/secondary1_private_ip/'${module.EC2-Secondary1.instance_private_ip}'/' ../AWS/Storage/ansible.yml"
  }
  provisioner "local-exec" {
    command = "sed -i 's/secondary2_private_ip/'${module.EC2-Secondary2.instance_private_ip}'/' ../AWS/Storage/ansible.yml"
  }
}


resource "null_resource" "ansible" {
  depends_on = [
    module.EC2-Primary,
    module.EC2-Secondary1,
    module.EC2-Secondary2,
    null_resource.get_ip
  ]
  provisioner "local-exec" {
    command = "ansible-playbook ../AWS/Storage/ansible.yml"
  }
}


// Create Application Load Balancer
module "myALB" {
  source                 =     "../AWS/ALB"
  lb_sg                  =     ["${module.mySecurity.LB_SG_ID}"]
  pub_subnets            =     ["${module.myVPC.Subnet_IDs[0]}", "${module.myVPC.Subnet_IDs[1]}"] // 1st 2 subnets will be public
  cert_arn               =     var.generate_cert_lb ? module.acm.cert_arn : var.lb_cert_arn # get arn from acm or manuall
  tag                    =     "${var.tag_name}-MERN"
  vpc_id                 =     module.myVPC.VPC_ID
  PORT                   =     var.PORT # Application port
}

// Create Auto Scaling Group from launch configuration & AMI
module "myASG" {
  depends_on = [ null_resource.ansible ]
  source                 =     "../AWS/ASG"
  spot_instance          =     var.spot_instance # if true creates spot instance
  ami_id                 =     var.ami_id_asg #"ami-0c501d8533397cba8" # AMI created using packer tool
  instance_type          =     var.instance_type_asg
  target_value_avg_cpu   =     var.target_value_avg_cpu
  min_capacity_asg       =     var.min_capacity_asg
  max_capacity_asg       =     var.max_capacity_asg
  grace_period           =     var.grace_period
  cooldown_period        =     var.cooldown_period
  desired_capacity_asg   =     var.desired_capacity_asg
  key_name               =     var.key_name
  iam_role_name          =     var.iam_role_name
  backend_sg             =     ["${module.mySecurity.Backend_SG_ID}"]
  // 1st two private subnet will be choosen
  subnets                =     ["${module.myVPC.Subnet_IDs[var.public_subnet_count]}", "${module.myVPC.Subnet_IDs[var.public_subnet_count + 1]}"] 
  MONGODB_DEV_URI        =     "mongodb://sqops:sqops321@${module.EC2-Primary.instance_private_ip}:27017,${module.EC2-Secondary1.instance_private_ip}:27017,${module.EC2-Secondary2.instance_private_ip}:27017/conduit?authSource=admin&replicaSet=rs10"
  target_group_arn       =     module.myALB.target_group_arn
  PORT                   =     var.PORT # Application port
  tag                    =     "${var.tag_name}-MERN"
}


// Create Pritunl VPN Server
module "myVPN" { 
  source              =     "../AWS/PritunlVPN"
  public_subnet_id    =     "${module.myVPC.Subnet_IDs[0]}"
  vpc_id              =     module.myVPC.VPC_ID  # using the output of vpc module
  pritunl_sg          =     ["${module.mySecurity.Pritunl_SG_ID}"]
  key_file_path       =     var.key_file_path
  spot_instance       =     var.spot_instance
  key_name            =     var.key_name
}

// Created Route53 create to point domain to LB dns 
module "route53" {
  count_value         =     var.create_record_for_lb
  source              =     "../AWS/Route53"
  subdomain_name      =     var.create_record_for_lb ? var.subdomain_name : null
  record_type         =     var.create_record_for_lb ? var.record_type : null
  hosted_zone_name    =     var.create_record_for_lb ? var.hosted_zone_name : null
  record              =     var.create_record_for_lb ? module.myALB.lb_dns : null    #LB DNS
  resource_zone_id    =     var.create_record_for_lb ? module.myALB.zone_id : null
}

// Create Amplify for MERN Application frontend
module "amplify" {
  source                 =     "../AWS/Amplify"
  count_value            =     true # condition for domain association
  repo_url               =     var.repo_url
  github_access_token    =     var.github_access_token
  backend_url            =     var.backend_url 
  branch_name            =     var.branch_name
  subdomain_name_amp     =     var.subdomain_name_amp
  domain_name_amp        =     var.hosted_zone_name
}

