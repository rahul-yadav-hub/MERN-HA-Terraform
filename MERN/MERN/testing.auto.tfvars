// General Variables
spot_instance            = false
tag_name                 = "Rahul-tf"
key_name                 = "rahul_sq"

// Provider Variables
region                   = "us-west-2"

// acm Module Variables
generate_cert_lb         = true
hosted_zone_name         = "rtd.squareops.co.in"                    #if false leave empty
subdomain_name           = "rahul-backend.rtd.squareops.co.in"     #if false leave empty

// acm_amp Module Variables
generate_cert_amplify    = true 
subdomain_name_amp_acm   = "rahul-frontend.rtd.squareops.co.in"      #if false leave empty

// VPC Variables
vpc_name                 = "Custom-VPC"
cidr_block_vpc           = "10.0.0.0/16"
public_subnet_count      = 2
private_subnet_count     = 2


// MongoDB variables
ami_id_DB               = "ami-0ddf424f81ddb0720" # ubuntu 20
instance_type_DB        = "t3a.small"
script_path_DB          = "/root/squareOps/ansible/mern-tf/MERN-CI-CD/AWS/Storage/EC2/script.sh"

// ALB Variables
PORT                     = "3000"                       # Application port
lb_cert_arn              = "" #provide imported cert arn if false

// ASG Variables
instance_type_asg        = "t3a.micro"
ami_id_asg               = "ami-068cea625a258ab1f"     # MERN AMI
iam_role_name            = "Rahul-ec2-CloudWatchAgent-and-SSM"
target_value_avg_cpu     = "50.0"
min_capacity_asg         = "1"
max_capacity_asg         = "2"
grace_period             = "400"
cooldown_period          = "120" 
desired_capacity_asg     = "1"

// Pritunl Variables
key_file_path            = "../../../../rahul_sq.pem"

// Route53 Variables
create_record_for_lb     = true
record_type              = "A"                           #"A"          # if true provide

// Amplify Variables
repo_url                 = "https://github.com/rahul-yadav-hub/react-redux-realworld-example-app.git"
github_access_token      = ""
branch_name              = "main"
backend_url              = "https://rahul-backend.rtd.squareops.co.in/api/"
subdomain_name_amp       = "rahul-frontend"

