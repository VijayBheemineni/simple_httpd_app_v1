resource "aws_autoscaling_group" "simple_httpd" {
  min_size         = var.asg_min_size
  max_size         = var.asg_max_size
  desired_capacity = var.asg_desired_capacity_size
  launch_template {
    id      = aws_launch_template.simple_httpd.id
    version = "$Latest"
  }
  vpc_zone_identifier = var.public_subnets
}

resource "aws_autoscaling_attachment" "asg_tg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.simple_httpd.id
  lb_target_group_arn    = aws_lb_target_group.simple-httpd.arn

  depends_on = [
    aws_autoscaling_group.simple_httpd,
    aws_lb_target_group.simple-httpd
  ]
}


