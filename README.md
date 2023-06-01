# Docker Basics
We'll first review some of the most basic concepts and slowly move to more advanced concepts. We'll start by defining a typical Docker workflow and start packaging a source code into an image, push it to the Docker Hub, pull it again, and run it as a container. We'll then continue the whole declarative deployment concepts and how to run multi-container applications using docker-compose. We'll finish up the basics by introducing Docker Swarm. 
### Docker workflow

Docker is a way to package an application and all their dependencies into one isolated environment. There are a few steps in running a containerized application: 

- We would first package the application into a Docker Image shared into a docker registry, such 
as docker hub. 
- We would then need to pull that image and run it as a container. 

The above two steps would require running a few commands. For the first part, packaging the source code into a docker image, we would have to create the Dockerfile first with all
the required steps. We'll come back to it later, but for now let's go back to basics.

### What is Docker? 
Docker is an open-source platform that allows packaging an application into a lightweight, isolated environment, called container. So, containers are units that encapsulate the whole application like, its dependencies and necessary runtime environment. Using containers, we can run a whole application across multiple computing environment. Here are a few advantages from a Data Engineering perspective:

- **Consistency -** You can package your data engineering applications with all their depencencies and configuration into a container. This ensures to reproduce the same results across all development stages. 

- **Portability and scalability -** Portability means that you can package your application into a 
container and run it on any infrastructure that supports Docker, whether in cloud or on-premise. Containers also support horizontal scaling, which means you can scale your data processing application by deploying multiple instances of the containers
- **Resource efficiency -** Containers are lightweight, consuming fewer resources as virtual machines. This allows data engineers to reduce infrastructure costs, especially when dealing with large-scale data processing workloads.
- **Easy deployment -** Docker simplifies the deployment of applications and microservices. You can package a whole microservice and its dependencies into a portable artificat. These images can then be deployed across multiple environments.

- **DevOps and CI/CD processes -** Docker plays a crucial role in DevOps modern practices. A Docker image can be used as an Artifact within a CI/CD proceses, that ensures consistent and reproducible builds, testing and deployment.

### Building on the first workflow

- The first step would be to package the source code into a Docker Image and push it into a Docker registry. In order to do this, we would need to create a Dockerfile and specify a set of build instructions. It's a set of instructions for Docker to build the application and its dependencies into a container image. 

- Once you have created the Dockerfile in your repository, use the ```docker image build -t moeint/gsd:first-ctr .``` command to package it into an image and push it into the dockerhub. ***moeint*** is the dockerhub id to push the image to; and ***gsd*** is the name of the repository; and finally, ***first-ctr*** is the actuall name of the image. The final period at the end of command means that all the file required to build the image, especially the Dockerfile, is available to the repository I'm running this command from. We would have had to provide its location if that weren't the case.

- Once the image is created, you can go ahead and run it locally, however, it's always better practice to push it to a docker hub. run the ```docker image push moeint/gsd:first-ctr``` command to do so; you might need to login to your account first using ```docker login``` before pushing it remotely.

- Once we have pushed the image remotely, we can run it directly from the local machine, or pull it from the hub again and run it. Use the ```docker container run -d --name web -p 8000:8080 moeint/gsd:first-ctr``` command to do so. It'll first look at the images locally, if it doesn't exists, it'll pull it from the Dockerhub and run it locally as a container. 

- In order to stop the running container, run the ```docker container stop web``` command, web being the name of the running container.

- To see a list of all running and stopped containers, run the ```docker container ls -a``` command.

- See the list of all running and stopped containers by running ```docker container rm web``` command.

### Multi-container applications with Docker
Microservices architecture is a style where applications are built as a collection of small, loosely-coupled microservices. Each microservice can be responsible for a part of the bussiness logic and can be developed, deployed and scaled independently.  

### Declarative deploymeny 
This term refers to the practice of defining the final state of your infrastructure or application using a declarative configuration file, typically in a YAML file. This approach focuses on describing the final state, rather than providing details on every required step to reach that final state. 

### Docker Compose
Docker-compose allows you to manage and define your multi-container applications using a declarative approach in a YAML file. This file describes services, networks, volumes and configurations of your applications in a single docker-compose.yaml file. For example, an application might need a web server and a database; we can define both these components in a yaml file and run the whole application using a single docker compose command. 

- Using the ```docker-compose.yaml``` we won't need to use the docker commands manually to build or pull or run docker images. We will define the final state of what's required and everything else gets taken care of under the hood. 

- This is a better practice to document and keep track of containers running in a multi-container applications.

### Docker Swarm 
Docker Swarm is a native clusteing and orchestration solution provided by Docker; it allows you to create and manage a swarm of Docker nodes and join them into a unified docker engine. 

- In a Docker swarm, there are two types of Docker nodes, the worker node, and the manager node. The manager node is responsible for managing the cluster and coordinating the activities of the worker nodes; the worker nodes however, are responsible for the actual execution of containers. 

- In Docker Swarm, you can use the final state of the containerized application through docker-compose.yaml file and take advantage of declarative deployments. 

Here how we can **Deploy and manage multiple services in a Docker Swarm cluster**: 

Within the ```-c docker-compose.yaml``` file under the swarm-stack folder, we have defined two services: a redis database, and 10 replicas on the web application. Stacking these two services within Docker Swarm, the request get distributed and balanced across 10 containers. Here's a detailed instruction to get the stack up and running: 

- Under the swarm-stack folder, we have a multi-container application defined in the docker-compose.yaml file. Using Docker Swarm, we cannot build an image on the fly; we need to first have the image created by running ```docker image build -t moeint/gsd:swarm-stack .``` and push it remotely using the ```docker image push moeint/gsd:swarm-stack``` command. 

- Once that done, usg the ```docker stack deploy``` command to deploy a stack of services to the Docker Swarm cluster. Use the ```-c docker-compose.yaml``` argument and pass in the docker-compose file; the file describes the final state of the services including their dependencies and configurations and related information. 

- Pass in a name as an identifier for the group of services that will be deployed as a whole. Here would be the final command: ```docker stack deploy -c docker-compose.yaml counter```. By running this command, Docker Swarm will create the services described within the docker-compose file. These services will be scheduled and distributed across the worker nodes. Using this approach, we can manage and deploy multiple services as a unified stack in a Swarm cluster. 

- Once the swarm stack is created, check it and the running services using the ```docker stack ls``` command. Use the ```docker stack services counter``` command to get more details on each service within the stack. 

- We can modify the number of replicas and run the docker stack command again; the stack gets updated. Run the ```stack ps counter``` command to get more details on all the replicas. 