locals {
  auth = {
    "access_key" : var.access_key
    "secret_key" : var.secret_key
  }

  assume_elasticbeanstalkrole_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "ec2.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF

  ebsSettings = {
    "ServiceRole" = {
      "namespace" = "aws:elasticbeanstalk:environment"
      "name"      = "ServiceRole"
      "value"     = "aws-elasticbeanstalk-service-role"
    },
    "IamInstanceProfile" = {
      "namespace" = "aws:autoscaling:launchconfiguration"
      "name"      = "IamInstanceProfile"
      "value"     = "aws-elasticbeanstalk-ec2-role"
    },
    "Tier" = {
      "namespace" = "aws:elasticbeanstalk:environment:Process:default"
      "name"      = "Tier"
      "value"     = "Standard"
    }
  }
}