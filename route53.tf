resource "aws_route53_record" "www" {
  zone_id = var.route53_hosted_zone_id
  name    = local.route53_record_name
  type    = "A"

  alias {
    name                   = aws_lb.simple_httpd.dns_name
    zone_id                = aws_lb.simple_httpd.zone_id
    evaluate_target_health = true
  }
}
