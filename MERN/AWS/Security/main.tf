// Define Sg for Bastion server
resource "aws_security_group" "Bastion-sg" {
  name        = "Rahul-tf-Bastion-server"
  description = "Allow SSH traffic"
  vpc_id      = var.vpc_id     #module.myVPC.VPC_ID #"vpc-04a220b2e6d81a4d5"

  // Incoming Traffic
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // outgoining traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.tag
  }
}

// Define Sg for ALB
resource "aws_security_group" "MERN-LB-sg" {
  name        = "Rahul-tf-MERN-LB"
  description = "Allow public traffic"
  vpc_id      = var.vpc_id     #module.myVPC.VPC_ID #"vpc-04a220b2e6d81a4d5"

  // Incoming Traffic
  ingress {
    description = "HTTP"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // outgoining traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.tag
  }
}

// Define Sg for MERN Backend (NODE)
resource "aws_security_group" "backend-sg" {
  name        = "Rahul-tf-MERN-backend"
  description = "Allow custom tpc traffic from LB"
  vpc_id      = var.vpc_id     #module.myVPC.VPC_ID #"vpc-04a220b2e6d81a4d5"

  // Incoming Traffic
  ingress {
    description = "TCP"
    from_port   = 3000
    to_port     = 3000
    protocol    = "tcp"
    security_groups = ["${aws_security_group.MERN-LB-sg.id}"] # Allow only LB SG
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.Bastion-sg.id}"] 
  }

  // outgoining traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.tag
  }
}

// Define Sg for MongoDB
resource "aws_security_group" "mongodb-sg" {
  name        = "Rahul-tf-mongoDB"
  description = "Allow MongoDB traffic"
  vpc_id      = var.vpc_id     #module.myVPC.VPC_ID #"vpc-04a220b2e6d81a4d5"

  // Incoming Traffic
  ingress {
    description = "MongoDB"
    from_port   = 27017
    to_port     = 27017
    protocol    = "tcp"
    security_groups = ["${aws_security_group.backend-sg.id}"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    security_groups = ["${aws_security_group.Bastion-sg.id}"] 
  }
  
  // outgoining traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.tag
  }
}



// Define Sg for Pritunl VPN server
resource "aws_security_group" "pritunl-sg" {
  name        = "Rahul-tf-Pritunl"
  description = "Allow HTTPS & SSH traffic"
  vpc_id      = var.vpc_id

  // Incoming Traffic
  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  // outgoining traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    Name = var.tag
  }
}

