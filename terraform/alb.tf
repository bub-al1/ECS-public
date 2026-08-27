resource "aws_lb" "main" {
  name               = "threatmod-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id] 
  subnets            = [
    aws_subnet.subnettest.id,  
    aws_subnet.subnettest2.id
  ]
  
  enable_deletion_protection = false  

  tags = {
    Name = "threatmod-alb"
  }
}
resource "aws_lb_target_group" "ecs" {
  name        = "threatmod-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpctest.id  
  target_type = "ip" 
  
  health_check {
    path = "/health" 
  }

  tags = {
    Name = "threatmod-tg"
  }
}


resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.main.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-TLS-1-2-2017-01"
  certificate_arn   = aws_acm_certificate.main.arn
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.ecs.arn
  }
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.main.arn
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
