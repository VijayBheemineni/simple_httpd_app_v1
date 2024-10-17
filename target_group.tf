resource "aws_lb_target_group" "simple-httpd" {
  name     = var.application_name
  port     = var.tg_target_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    path = var.tg_healthcheck_path
    // TODO: Create variables for all below attributes
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 6
  }
}
