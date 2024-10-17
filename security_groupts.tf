resource "aws_security_group" "allow_http" {
  name        = join("-", [var.application_name, "alb"])
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_http_world" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_https_world" {
  security_group_id = aws_security_group.allow_http.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_egress_rule" "alb_allow_all_traffic" {
  security_group_id = aws_security_group.allow_http.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}


resource "aws_security_group" "ec2_simple_httpd" {
  name        = join("-", [var.application_name, "ec2"])
  description = "Simple Httpd EC2 instances security group "
  vpc_id      = var.vpc_id
}

resource "aws_vpc_security_group_ingress_rule" "allow_alb_traffic" {
  description                  = "Allows traffic from ALB"
  from_port                    = 80
  to_port                      = 80
  ip_protocol                  = "tcp"
  referenced_security_group_id = aws_security_group.allow_http.id
  security_group_id            = aws_security_group.ec2_simple_httpd.id

  depends_on = [aws_security_group.allow_http]
}

resource "aws_vpc_security_group_egress_rule" "ec2_allow_all_traffic" {
  security_group_id = aws_security_group.ec2_simple_httpd.id

  cidr_ipv4   = "0.0.0.0/0"
  ip_protocol = -1
}
