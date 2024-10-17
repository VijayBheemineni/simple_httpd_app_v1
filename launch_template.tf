resource "aws_launch_template" "simple_httpd" {
  name          = var.application_name
  description   = "Simple Httpd Launch Template"
  ebs_optimized = true
  image_id      = data.aws_ami.linux.id
  instance_type = var.lt_instance_type
  # Comment out the following after testing
  # key_name = var.lt_key_name
  monitoring {
    enabled = true
  }
  network_interfaces {
    # Set it to false
    associate_public_ip_address = true
    security_groups             = [aws_security_group.ec2_simple_httpd.id]
  }
  # vpc_security_group_ids = [aws_security_group.ec2_simple_httpd.id]
  user_data = filebase64("${path.module}/scripts/user-data.sh")

  lifecycle {
    create_before_destroy = true
  }
}
