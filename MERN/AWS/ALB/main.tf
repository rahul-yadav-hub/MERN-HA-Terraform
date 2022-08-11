
resource "aws_lb_target_group" "myTG" {
  name     = var.tag
  port     = var.PORT
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
      healthy_threshold = 2
        path = "/"
        port = var.PORT
        protocol = "HTTP"

  }
}

resource "aws_lb" "myALB" {
  name               = var.tag
  internal           = false
  load_balancer_type = "application"
  security_groups    = var.lb_sg
  subnets            = var.pub_subnets

  tags = {
    Name = var.tag
  }
}

# resource "aws_lb_target_group_attachment" "lb_attach" {
#   depends_on = [
#     aws_lb.myALB,
#     aws_lb_target_group.myTG
#   ]
#   target_group_arn = aws_lb_target_group.myTG.arn
#   target_id        = aws_lb.myALB.arn
#   port             = var.PORT
# }

resource "aws_lb_listener" "HTTPS" {
    depends_on = [
      aws_lb.myALB
    ]
  load_balancer_arn = aws_lb.myALB.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.myTG.arn
  }
}

resource "aws_lb_listener" "HTTP" {
  load_balancer_arn = aws_lb.myALB.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}


