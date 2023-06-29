<p align="center">
  <img width="400" height="170" src=./assets/AWSDocker.jpg>
</p>

# Docker and AWS Elastic Beanstalk Documentation
This documentation provides an overview of the project and highlights important aspects related to Docker, AWS Elastic Beanstalk, CI/CD pipeline, and Infrastructure as Code with Terraform. It also outlines the steps involved in setting up and deploying a React application.

## Project Objective
The main objective of this repository is to indicate how to work with Docker, containerization of web applications, and deploy them into AWS Elastic Beanstalk. The project focuses on the following high-level steps:

- Created a simple React application that includes a welcome page.
- Developed a Dockerfile.dev file to build an image for running and testing the development version of the application.
- Created a Dockerfile based on the Nginx image to run the production version of the web application.
- Placed all the source code, along with the Dockerfiles, inside the ```./frontend``` repository.
- Successfully deployed the ```./frontend``` repository as a zip file into AWS Elastic Beanstalk.
- Implemented deployments into AWS Elastic Beanstalk using CI/CD pipelines with GitHub Actions.
- Utilized Terraform for infrastructure provisioning and management, integrating it with CI/CD using GitHub Actions.

## CI/CD Pipeline for React Application Deployment
The project incorporates a CI/CD pipeline to automate the creation, testing, and deployment of the React application in AWS Elastic Beanstalk. The pipeline follows these steps:

Step 1: Building the Docker image for the development version of the application:

```
docker build -t moeint/react-test -f Dockerfile.dev .
```

Step 2: Running tests on the development version of the application using the following command:

```
docker run -e CI=true moeint/react-test npm test
```

Step 3: Once the above steps are successfully completed, deploying the production version of the application to AWS Elastic Beanstalk.

The CI/CD workflow executes only when a pull request is merged into the main branch.

See all the above steps under ```.github/workflows/docker-deploy.yaml```. 

## Infrastructure as Code with Terraform
This project emphasizes Infrastructure as Code principles, leveraging Terraform to provision and manage the required infrastructure for deploying source code into AWS Elastic Beanstalk. The following resources have been created using Terraform:

1. **aws-elasticbeanstalk-ec2-role:** A role named `aws-elasticbeanstalk-ec2-role` along with an instance profile, granting the following permissions:

 - AWSElasticBeanstalkWorkerTier
 - AWSElasticBeanstalkMulticontainerDocker
 - AdministratorAccess-AWSElasticBeanstalk
 - AWSElasticBeanstalkWebTier

2. **aws-elasticbeanstalk-service-role:** The existing role `aws-elasticbeanstalk-service-role` available in AWS has been imported into the Terraform management. It has been assigned the following permissions:

 - AWSElasticBeanstalkManagedUpdatesCustomerRolePolicy
 - AdministratorAccess-AWSElasticBeanstalk
 - AWSElasticBeanstalkEnhancedHealth

3. **Elastic Beanstalk Application and Environment:** An Elastic Beanstalk Application and an Elastic Beanstalk Environment have been created. The roles created in Step 1 and Step 2 have been assigned to the environment. All these dependencies have been properly managed with Terraform. 

Deployment of the above infrastructure is achieved through a CI/CD pipeline. The deployment process consists of two steps:

 - When pushing to the feat/dockerActions branch, a Terraform plan is executed. This step allows reviewing the plan before the actual deployment. See the workflow on ```.github/workflows/tf-pipeline-check-staging.yaml```.
 - Upon a pull request to the main branch, a Terraform apply is triggered to deploy the infrastructure. Successful deployments can be merged into the main branch. See this workflow ```.github/workflows/tf-pipeline-deploy-staging.yml```.

## Conclusion
This documentation provides an overview of the project's objectives, the CI/CD pipeline for React application deployment, and the use of Infrastructure as Code with Terraform for managing AWS Elastic Beanstalk infrastructure. Below we can see a schematic representation of the whole end-to-end deployments for both the source code and the required infrastructure in AWS: 

<p align="center">
  <img width="400" height="170" src=./assets/OverallWorkflow.png>
</p>


## Contact 
- moin.torabi@gmail.com
- [LinkedIn](https://www.linkedin.com/in/moeintorabi/)