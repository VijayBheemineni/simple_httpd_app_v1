output "simple_httpd_alb_application_url" {
  description = "Simple HTTP ALB application url"
  value       = "http://${module.simple_http_app.alb_dns_name}/index.html"
}

output "simple_httpd_application_url" {
  description = "Simple HTTP application url"
  value       = "https://${module.simple_http_app.route53_simple_httpd_record_name}/index.html"
}
