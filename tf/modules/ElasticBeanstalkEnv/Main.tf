terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

# Configure the AWS Provider
provider "aws" {
  region     = var.aws_region
  access_key = var.auth.access_key
  secret_key = var.auth.secret_key
}


# EBS envs
resource "aws_elastic_beanstalk_environment" "AllEnvs" {

  for_each = var.ebsEnvs

  name                = each.value.name
  application         = each.value.application
  solution_stack_name = each.value.solution_stack_name

  dynamic "setting" {
    for_each = each.value.allSettings
    content {
      namespace = setting.value.namespace
      name      = setting.value.name
      value     = setting.value.value
    }
  }
}