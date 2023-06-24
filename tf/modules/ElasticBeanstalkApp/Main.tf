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


# EBS Apps
resource "aws_elastic_beanstalk_application" "AllApps" {

  for_each = var.ebsApps

  name        = each.value.name
  description = contains(keys(each.value), "description") ? each.value.description : null
}