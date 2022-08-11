

resource "aws_instance" "instance" {
  ami                         = var.ami_id
  instance_type               = var.instance_type
  key_name                    = var.key_name
  vpc_security_group_ids      = var.sg_id
  subnet_id                   = var.public_subnet_id
  tags = {
    Name = var.tag
  }
  user_data = file("${var.script_path}")
}

