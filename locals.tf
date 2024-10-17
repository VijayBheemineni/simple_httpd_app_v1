locals {
  route53_record_name = join(".", [var.application_name, var.route53_hosted_zone_name])
}
