# simple_httpd_app
Just simple httpd app to test AWS Service concepts

# Requirements
- Application Load Balancer (proper use of HTTP and HTTPS)
- Auto Scaling Group
- 2 instances
- Related DNS
- Related monitoring and alerting
- Relevant security and best practices for each type of resource
- How would they organize for a multi-account setup in the template
- How would they deploy in a multi-account environment.
- How they comment the file so that the code is understandable

# Coding Assumptions
- Generally AMI which contains application configuration is created using AMI builder or separate pipeline. In this case we are using Amazon Linux AMI and installing 'httpd' in runtime through 'user-data'.
- We will getting Amazon Linux AMI through 'Terraform' datasource resource 'aws_ami'.
- We will not focusing on various ALB scaling strategies like 'step', 'target', 'predictive' or 'scheduled'. We will use 'simple' scaling for this demo.
- Assuming route53 hostedzone already exists. 
- Assuming ACM certificate exists for route53 hosted domain. 
- Attaching WAF to ALB is a good practice. But we will not be implementing for the demo.
- Have CloudFront which forwards Static content to S3 and dynamic content requests to EC2 instances would be better optoin. But we will not be implementing for the demo.
- Not using Terraform S3 backend to store the state of infrastructure.

# Todo List
- Create Security groups. One for ALB, one for EC2 instances :- Implemented
- Create TG :- Implemented
- Create ALB :- Implemented
- Create Launch Template  :- Implemented 
- Create ASG :- Implemented
- Create Route53 record in existing domain  :- Implemented

# Security

As per NIST Framework, we have 5 phases.
- Identify :- Identify all the resources. We can do this at Application level, Account Level, and Organization level
- Protect :- Follow 'Defence in Depth' approach. Using SG, NACL, WAF, CloudFront, API Gateway, Shield, Using roles, STS, Encryption, KMS.
- Detect :- Detect security threats using various tools like 'Config', 'Inspector', 'GuardDuty', 'Security Hub', 'CloudTrail', 'Trusted Advisor', 'Detective', 'VPC Flow Logs', Cloudwatch Alarms etc.
- Respond :- Security Hub, SNS, or any CSPM(Cloud Security Posture Management)
- Recover :- Build automated tools using like 'Event Bridge' and 'Lambda' which can take action based on security event.

In this demo
- EC2 instances have no ssh key. So no one can login. They allow traffic only on port 80 from ALB security group. We can install AWS Inspector agent or use agentless to scan these instances frequently. Also at the account level 'EBS' encryption can be enabled.
- WAF can be attached to ALB to protect Layer 7 attacks or block by country or block by ip address or rate limiting.
- We can further improve this architecture by placing 'CloudFront' before ALB which allows to pull static resources from S3 and forwards dynamic content request to ALB.

# Monitoring

Before implementing monitoring, we need to understand what we want to monitor. We can use monitoring tools like 'CloudWatch', 'Datadog', 'Prometheus', 'NewRelic' etc

In this 'simple httpd' app demo example, we have the resources

    - EC2 Instances
    - ALB
    - WAF(Needs to implemented)
    - Route53
    - CloudFront(Needs to implemented)

## Infrastructure Monitoring

    Using CloudWatch and CloudWatch logs we can monitor below services. We can build 'CloudWatch' dashboard which displays all metrics relateed to application.

    - EC2 :- CloudWatch Metrics for EC2 instance. In order to monitor memory we need to install 'CloudWatch' agent. This will be part of AMI. Also we can push Apache logs to cloudwatch and use 'Cloudwatch Insights' to analyze patterns and create custom metrics if required. 
    - ALB :- Cloudwatch metrics
    - WAF :- CloudWatch metrics
    - Route53 :- CloudWatch metrics

## Security Monitoring
    Monitor the infrastructure for security related events using below services.

    - Inspector
    - Guardduty
    - Security Hub

## Application monitoring
    We can push 'custom' metrics related to 'httpd' and push them to 'Cloudwatch'.

## Multi Account Deployment

    Below is the strategy we used for Bitbucket pipelines.
    
    - Configured bitbucket as a web identity provider on AWS. We have created this role in all AWS accounts we need to deploy the resources.  The steps at high levels involve:
        - Creating an identity provider.
        - Creating an IAM role.
        - We are selecting a web identity as a trusted entity. 
    
    - In Bitbucket pipelines, for each environment we had defined "Deployment" and defined required variable of which one of the variable is "BITBUCKET_AWS_ROLE". 
    - Bitbucket pipeline when it tries to deploy to the environment it assumes the role and deploys the resources to particular AWS account as per steps defined in the 'bitbucket-pipelines.yml' file.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.46 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.46 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_autoscaling_attachment.asg_tg_attachment](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_attachment) | resource |
| [aws_autoscaling_group.simple_httpd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/autoscaling_group) | resource |
| [aws_launch_template.simple_httpd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/launch_template) | resource |
| [aws_lb.simple_httpd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb) | resource |
| [aws_lb_listener.http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_listener.https](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_listener) | resource |
| [aws_lb_target_group.simple-httpd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb_target_group) | resource |
| [aws_route53_record.www](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record) | resource |
| [aws_security_group.allow_http](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_security_group.ec2_simple_httpd](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/security_group) | resource |
| [aws_vpc_security_group_egress_rule.alb_allow_all_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_egress_rule.ec2_allow_all_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_egress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_alb_traffic](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_http_world](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_vpc_security_group_ingress_rule.allow_https_world](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc_security_group_ingress_rule) | resource |
| [aws_ami.linux](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/ami) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alb_enable_deletion_protection"></a> [alb\_enable\_deletion\_protection](#input\_alb\_enable\_deletion\_protection) | Allows to delete ALB or not. If true doesn't allow to delete ALB | `bool` | `false` | no |
| <a name="input_alb_https_security_policy"></a> [alb\_https\_security\_policy](#input\_alb\_https\_security\_policy) | HTTPS listener security policy | `string` | `"ELBSecurityPolicy-TLS13-1-3-2021-06"` | no |
| <a name="input_alb_https_ssl_cert_arn"></a> [alb\_https\_ssl\_cert\_arn](#input\_alb\_https\_ssl\_cert\_arn) | SSL Cert ARN | `string` | `"arn:aws:acm:us-east-1:981344819203:certificate/883f69fd-b56e-4bda-afec-6a7b7244ef2a"` | no |
| <a name="input_alb_internal"></a> [alb\_internal](#input\_alb\_internal) | Is ALB internal? | `bool` | `false` | no |
| <a name="input_application_name"></a> [application\_name](#input\_application\_name) | Application Name. This name will be used to prefix all resources | `string` | n/a | yes |
| <a name="input_asg_desired_capacity_size"></a> [asg\_desired\_capacity\_size](#input\_asg\_desired\_capacity\_size) | ASG Desired Capacity Size | `number` | `2` | no |
| <a name="input_asg_max_size"></a> [asg\_max\_size](#input\_asg\_max\_size) | ASG Maxinum Size | `number` | `2` | no |
| <a name="input_asg_min_size"></a> [asg\_min\_size](#input\_asg\_min\_size) | ASG Minimum Size | `number` | `2` | no |
| <a name="input_lt_instance_type"></a> [lt\_instance\_type](#input\_lt\_instance\_type) | Instance type | `string` | `"t2.micro"` | no |
| <a name="input_lt_key_name"></a> [lt\_key\_name](#input\_lt\_key\_name) | SSH Key Name | `string` | `"vijay-dummy-temp"` | no |
| <a name="input_private_subnets"></a> [private\_subnets](#input\_private\_subnets) | private subnets | `list(string)` | <pre>[<br>  "subnet-03a8a03da1ba56300",<br>  "subnet-03d1a80111e81fe58"<br>]</pre> | no |
| <a name="input_public_subnets"></a> [public\_subnets](#input\_public\_subnets) | public subnets | `list(string)` | <pre>[<br>  "subnet-0788e3bcb0384139d",<br>  "subnet-0da4e3259d40ede3c"<br>]</pre> | no |
| <a name="input_route53_hosted_zone_id"></a> [route53\_hosted\_zone\_id](#input\_route53\_hosted\_zone\_id) | Route53 Hosted Zone ID | `string` | `"Z062437715N75EOXBP1FA"` | no |
| <a name="input_route53_hosted_zone_name"></a> [route53\_hosted\_zone\_name](#input\_route53\_hosted\_zone\_name) | Route53 Hosted Zone Name | `string` | `"sandbox.nmcappstestnet.com"` | no |
| <a name="input_tg_healthcheck_path"></a> [tg\_healthcheck\_path](#input\_tg\_healthcheck\_path) | Target Health Check Path | `string` | `"/index.html"` | no |
| <a name="input_tg_target_port"></a> [tg\_target\_port](#input\_tg\_target\_port) | Target Port | `number` | `80` | no |
| <a name="input_vpc_id"></a> [vpc\_id](#input\_vpc\_id) | VPC ID | `string` | `"vpc-0acaba21c701400b3"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_alb_dns_name"></a> [alb\_dns\_name](#output\_alb\_dns\_name) | ALB DNS name |
| <a name="output_alb_name"></a> [alb\_name](#output\_alb\_name) | ALB name |
| <a name="output_alb_sg_id"></a> [alb\_sg\_id](#output\_alb\_sg\_id) | ALB Security Group ID |
| <a name="output_alb_sg_name"></a> [alb\_sg\_name](#output\_alb\_sg\_name) | ALB Security Group Name |
| <a name="output_ami_id"></a> [ami\_id](#output\_ami\_id) | AMI ID |
| <a name="output_route53_simple_httpd_record_name"></a> [route53\_simple\_httpd\_record\_name](#output\_route53\_simple\_httpd\_record\_name) | Route53 Record Name for simple httpd application |
| <a name="output_tg_arn"></a> [tg\_arn](#output\_tg\_arn) | Target Group ARN |
| <a name="output_tg_name"></a> [tg\_name](#output\_tg\_name) | Target Group Name |
<!-- END_TF_DOCS -->

