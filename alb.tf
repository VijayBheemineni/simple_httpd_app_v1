resource "aws_lb" "simple_httpd" {
  name               = var.application_name
  internal           = var.alb_internal
  load_balancer_type = "application"
  security_groups    = [aws_security_group.allow_http.id]
  subnets            = var.public_subnets

  enable_deletion_protection = var.alb_enable_deletion_protection


  depends_on = [
    aws_security_group.allow_http
  ]
}

resource "aws_lb_listener" "http" {
  load_balancer_arn = aws_lb.simple_httpd.arn
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

  lifecycle {
    create_before_destroy = true
  }

  depends_on = [
    aws_lb_target_group.simple-httpd
  ]
}

resource "aws_lb_listener" "https" {
  load_balancer_arn = aws_lb.simple_httpd.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = var.alb_https_security_policy
  certificate_arn   = var.alb_https_ssl_cert_arn

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.simple-httpd.arn
  }

  depends_on = [
    aws_lb_target_group.simple-httpd
  ]
}
