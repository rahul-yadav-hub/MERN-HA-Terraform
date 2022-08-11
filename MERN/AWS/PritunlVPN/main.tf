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

// Using spot instances
resource "aws_spot_instance_request" "Pritnul_server" {
  count = var.spot_instance ? 1 : 0
  ami = var.ami_type
  spot_price    = data.aws_ec2_spot_price.price.spot_price
  instance_type = var.instance_type
  #spot_type              = "one-time" // instance terminate after request closed
  instance_interruption_behavior = "stop"
  # block_duration_minutes = "120"
  wait_for_fulfillment = "true"
  key_name             = var.key_name
  vpc_security_group_ids      = var.pritunl_sg
  subnet_id            = var.public_subnet_id
  tags = {
    Name = var.tag
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.key_file_path}")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../AWS/PritunlVPN/script.sh" # Doubt
    destination = "/home/ubuntu/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/script.sh",
      "/home/ubuntu/script.sh",
    ]
  }
}


// Copy file from remote to local
resource "null_resource" "spot_get_credentials" {
  count = var.spot_instance ? 1 : 0
  depends_on = [
    aws_spot_instance_request.Pritnul_server
  ]
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no  -i ${var.key_file_path} ubuntu@${aws_spot_instance_request.Pritnul_server[0].public_ip}:/home/ubuntu/pritunlCreds.txt ."
//    interpreter = ["pwsh", "-Command"]
  }
}


// Using On Demand instances
resource "aws_instance" "Pritnul_server" {
  count = var.spot_instance ? 0 : 1
  ami = var.ami_type
  instance_type = var.instance_type
  key_name             = var.key_name
  vpc_security_group_ids      = var.pritunl_sg
  subnet_id            = var.public_subnet_id
  tags = {
    Name = var.tag
  }
  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("${var.key_file_path}")
    host        = self.public_ip
  }

  provisioner "file" {
    source      = "../AWS/PritunlVPN/script.sh" #doubt
    destination = "/home/ubuntu/script.sh"
  }

  provisioner "remote-exec" {
    inline = [
      "sudo chmod +x /home/ubuntu/script.sh",
      "/home/ubuntu/script.sh",
    ]
  }
}


// Copy file from remote to local
resource "null_resource" "get_credentials" {
  count = var.spot_instance ? 0 : 1
  depends_on = [
    aws_instance.Pritnul_server
  ]
  provisioner "local-exec" {
    command = "scp -o StrictHostKeyChecking=no  -i ${var.key_file_path} ubuntu@${aws_instance.Pritnul_server[0].public_ip}:/home/ubuntu/pritunlCreds.txt ."
  //  interpreter = ["pwsh", "-Command"]
  }
}







