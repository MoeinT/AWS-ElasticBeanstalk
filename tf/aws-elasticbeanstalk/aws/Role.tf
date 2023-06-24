# Creating a role for the AWS Elastic Beanstalk environment
module "Role" {
  source = "../../modules/Role"
  auth   = local.auth
  roles = {
    aws-elasticbeanstalk-ec2-role = {
      "name"               = "aws-elasticbeanstalk-ec2-role",
      "assume_role_policy" = local.assume_elasticbeanstalkrole_policy
    }
  }
}

# Adding the below two policies to the above role
module "RolePolicy" {
  source = "../../modules/RolePolicy"
  auth   = local.auth
  policies = {
    "WorkerTier" = {
      "role"       = module.Role.rolename["aws-elasticbeanstalk-ec2-role"],
      "policy_arn" = "arn:aws:iam::aws:policy/AWSElasticBeanstalkWorkerTier"
    },
    "MulticontainerDocker" = {
      "role"       = module.Role.rolename["aws-elasticbeanstalk-ec2-role"],
      "policy_arn" = "arn:aws:iam::aws:policy/AWSElasticBeanstalkMulticontainerDocker"
    }
  }
}