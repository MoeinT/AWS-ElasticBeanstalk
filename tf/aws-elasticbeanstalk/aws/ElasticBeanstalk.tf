module "ebsApp" {
  source = "../../modules/ElasticBeanstalkApp"
  auth   = local.auth
  ebsApps = {
    "ebs" = {
      "name"        = "docker-react",
      "description" = "An Application for an Elastic Beanstalk Environment"
    }
  }
}

module "ebsEnv" {
  source = "../../modules/ElasticBeanstalkEnv"
  auth   = local.auth
  ebsEnvs = {
    "ebs" = {
      "name"                = "docker-react-env",
      "application"         = module.ebsApp.appname["docker-react"],
      "tier"                = "WebServer",
      "solution_stack_name" = "64bit Amazon Linux 2 v3.5.8 running Docker"
      "allSettings"         = local.ebsSettings
    }
  }
}