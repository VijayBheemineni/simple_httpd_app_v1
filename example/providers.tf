terraform {
  required_version = ">= 1.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.46"
    }
  }
}

provider "aws" {
  region = var.aws_region
  default_tags {
    tags = {
      "application_name" = "abc"
      "created_by"       = "Vijay Bheemineni"
    }
  }
}
