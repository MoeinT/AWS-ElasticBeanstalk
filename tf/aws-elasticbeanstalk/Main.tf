terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
  backend "s3" {
    key            = "global/s3/staging.tfstate"
    bucket         = "tfstate-backend-docker"
    region         = "eu-west-3"
    dynamodb_table = "docker_state_locking"
    encrypt        = true
  }
}

# Configure the AWS Provider
provider "aws" {
}