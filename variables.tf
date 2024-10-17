/**
  Required Parameter
**/

variable "application_name" {
  description = "Application Name. This name will be used to prefix all resources"
  type        = string
}

/**
  Optional Parameters
*/
/** 
  VPC Parameters
*/
variable "vpc_id" {
  description = "VPC ID"
  type        = string
  default     = "vpc-0acaba21c7014567"
}

variable "public_subnets" {
  description = "public subnets"
  type        = list(string)
  default     = ["subnet-0788e3bcb0381534", "subnet-0da4e3259d4561"]
}

variable "private_subnets" {
  description = "private subnets"
  type        = list(string)
  default     = ["subnet-03a8a03da1ba58913", "subnet-03d1a80111e81f718"]
}

/**
  Target Group Parameters
*/
variable "tg_target_port" {
  description = "Target Port"
  type        = number
  default     = 80
}

variable "tg_healthcheck_path" {
  description = "Target Health Check Path"
  type        = string
  default     = "/index.html"
}

/**
  ALB Parameters
*/
variable "alb_internal" {
  description = "Is ALB internal?"
  type        = bool
  default     = false
}

variable "alb_enable_deletion_protection" {
  description = "Allows to delete ALB or not. If true doesn't allow to delete ALB"
  type        = bool
  default     = false
}

variable "alb_https_security_policy" {
  description = "HTTPS listener security policy"
  type        = string
  default     = "ELBSecurityPolicy-TLS13-1-3-2021-06"
}

variable "alb_https_ssl_cert_arn" {
  description = "SSL Cert ARN"
  type        = string
  default     = "arn:aws:acm:us-east-1:1234567890:certificate/883f69fd-b56e-4bda-afec-6a7b72441aef"
}

/** 
  Launch Template Parameters
*/

variable "lt_key_name" {
  description = "SSH Key Name"
  type        = string
  default     = "vijay-dummy-temp"
}

variable "lt_instance_type" {
  description = "Instance type"
  type        = string
  default     = "t2.micro"
}

/** 
  ASG Parameters
*/
variable "asg_min_size" {
  description = "ASG Minimum Size"
  type        = number
  default     = 2
}

variable "asg_max_size" {
  description = "ASG Maxinum Size"
  type        = number
  default     = 2
}

variable "asg_desired_capacity_size" {
  description = "ASG Desired Capacity Size"
  type        = number
  default     = 2
}

/** 
  Route53 Parameters
*/

variable "route53_hosted_zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
  default     = "Z062437715N75EOXBA1ZR"
}

variable "route53_hosted_zone_name" {
  description = "Route53 Hosted Zone Name"
  type        = string
  default     = "sandbox.dummy.com"
}
