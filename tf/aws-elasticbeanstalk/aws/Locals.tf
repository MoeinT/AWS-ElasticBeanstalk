locals {
  auth = {
    "access_key" : var.access_key
    "secret_key" : var.secret_key
  }

  assume_ebs_ec2_role_policy = <<EOF
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

  assume_ebs_servicerole_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
      {
          "Effect": "Allow",
          "Principal": {
              "Service": "elasticbeanstalk.amazonaws.com"
          },
          "Action": "sts:AssumeRole"
      }
  ]
}
EOF

  ebsSettings = {
    "ServiceRole" = {
      "namespace" = "aws:elasticbeanstalk:environment"
      "name"      = "ServiceRole"
      "value"     = module.Role.rolearn["aws-elasticbeanstalk-service-role"]
    },
    "IamInstanceProfile" = {
      "namespace" = "aws:autoscaling:launchconfiguration"
      "name"      = "IamInstanceProfile"
      "value"     = module.InstanceProfile.instanceprofilename["aws-elasticbeanstalk-ec2-role"]
    },
    "Tier" = {
      "namespace" = "aws:elasticbeanstalk:environment"
      "name"      = "EnvironmentType"
      "value"     = "SingleInstance"
    }
  }
}
