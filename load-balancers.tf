resource "aws_lb" "web_app" {
  name               = "web-app-lb-tf"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_app_sg.id]
  subnets            = [aws_subnet.subnet_public.id]
  
  tags = {
    "Environment"    = var.environment_tag
  }
}

resource "aws_lb_target_group" "web_app" {
  name               = "webapp-lb-tg"
  port               = 80
  protocol           = "HTTP"
  vpc_id             = "aws_vpc.vpc.id"
  }

resource "aws_lb_listener" "web_app" {
  load_balancer_arn  = aws_lb.web_app.arn
  port               = "80"
  protocol           = "HTTP"
  
  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_app.arn
  }
}

resource "aws_lb_target_group_attachment" "web_app" {
  target_group_arn   = aws_lb_target_group.web_app.arn
  target_id          = aws_instance.ruby_instance.id
  port               = 80
}
