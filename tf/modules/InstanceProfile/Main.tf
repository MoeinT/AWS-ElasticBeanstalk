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


# Creating Instance Profiles
resource "aws_iam_instance_profile" "AllInstanceProfiles" {
  for_each = var.instanceprofiles
  name     = each.value.name
  role     = each.value.role
}