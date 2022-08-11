
// Using spot instances
resource "aws_spot_instance_request" "Bastion_server" {
  ami = var.ami_type
  #spot_price             = "0.016"
  instance_type = var.instance_type
  #spot_type              = "one-time" // instance terminate after request closed
  instance_interruption_behavior = "stop"
  # block_duration_minutes = "120"
  wait_for_fulfillment = "true"
  key_name             = var.key_name
  vpc_security_group_ids  = var.bastion_sg
  subnet_id = var.public_subnet_id
  tags = {
    Name = var.tag_name
  }

  user_data = <<-EOF
                 #! /bin/bash
                 sudo apt update -y

  EOF

}



  
