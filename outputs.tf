/**
  Target group details
*/
output "tg_name" {
  description = "Target Group Name"
  value       = aws_lb_target_group.simple-httpd.name
}

output "tg_arn" {
  description = "Target Group ARN"
  value       = aws_lb_target_group.simple-httpd.arn
}

/**
  ALB Details
*/
output "alb_name" {
  description = "ALB name"
  value       = aws_lb.simple_httpd.name
}

output "alb_dns_name" {
  description = "ALB DNS name"
  value       = aws_lb.simple_httpd.dns_name
}

output "route53_simple_httpd_record_name" {
  description = "Route53 Record Name for simple httpd application"
  value       = local.route53_record_name
}

/**
  AMI information
*/

output "ami_id" {
  description = "AMI ID"
  value       = data.aws_ami.linux.id
}

/**
  Security Group Details
*/

output "alb_sg_name" {
  description = "ALB Security Group Name"
  value       = aws_security_group.allow_http.name
}

output "alb_sg_id" {
  description = "ALB Security Group ID"
  value       = aws_security_group.allow_http.id
}
