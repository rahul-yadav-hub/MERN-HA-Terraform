
// Fetch AZs
data "aws_availability_zones" "available" {
  state = "available"
}

// Query current spot price
data "aws_ec2_spot_price" "price" {
  instance_type     = var.instance_type
  availability_zone = data.aws_availability_zones.available.names[0]
  filter {
    name   = "product-description"
    values = ["Linux/UNIX"]
  }
}

data "template_file" "script" { 
  template = "${file("../AWS/ASG/script.sh")}"
  vars = {
    MONGODB_DEV_URI          = "${var.MONGODB_DEV_URI}"
    PORT                     = "${var.PORT}"
  }
}

resource "aws_launch_configuration" "launch_conf" {
  count = 1
  image_id      = var.ami_id
  instance_type = var.instance_type
  key_name = var.key_name
  iam_instance_profile = var.iam_role_name
  security_groups = var.backend_sg  
  spot_price    = var.spot_instance ? data.aws_ec2_spot_price.price.spot_price : null # gets current spot price if user request spot instances
  lifecycle {
    create_before_destroy = true
  }
  // without CI/CD
  user_data = "${data.template_file.script.rendered}" #"${file("../AWS/ASG/script.sh")}"
}

resource "aws_autoscaling_policy" "myPolicy" {
  depends_on = [
    aws_autoscaling_group.myASG
  ]
  name                   = var.tag
  policy_type = "TargetTrackingScaling"
  target_tracking_configuration {
    predefined_metric_specification {
      predefined_metric_type = "ASGAverageCPUUtilization"
    }
    target_value = var.target_value_avg_cpu // parameterized
  }
  autoscaling_group_name = aws_autoscaling_group.myASG.name
}

resource "aws_autoscaling_group" "myASG" {
  depends_on = [
    aws_launch_configuration.launch_conf
  ]
  name                 = var.tag
  launch_configuration = aws_launch_configuration.launch_conf[0].name
  min_size             = var.min_capacity_asg
  max_size             = var.max_capacity_asg
  health_check_grace_period = var.grace_period #400
  default_cooldown = var.cooldown_period #120
  health_check_type         = "ELB"
  desired_capacity          = var.desired_capacity_asg
  force_delete              = true
  vpc_zone_identifier       = var.subnets #list
  target_group_arns = [ var.target_group_arn ]
  tag {
    key                 = "Name"
    value               = var.tag
    propagate_at_launch = true
  }
  lifecycle {
    create_before_destroy = true
  }
}
