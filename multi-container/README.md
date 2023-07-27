# Multi-container application

## Docker compose
The docker compose file will be used to integrate all components of our multi-container application in a declarative way, and will be considered as the starting point to the application. Here are the services we used to the whole thing up & running.

- The first service specified in the file is postgres. We will not be creating this image from scratch, but instead we'll download it from [Dockerhub](https://hub.docker.com/_/postgres).

- We then specify the later version of the redis image from [Dockerhub](https://hub.docker.com/_/redis). So, when we execute the ```docker-compose up``` command, this image gets pulled from Dockerhub.

- We also need to specify the server component of the application. For this, we'll need to build an image from scratch using the Dockerfile.dev file we defined under the ```./server``` directory. For this we also specifed volumes to make sure all the changes in the source code get automatically projected to the running container. 

- Simlilar to the server, we've also added two more services to the docker-compose.yml file: one for the worker, and one for the client. 

### Docker Volume
For the server, we also specified a bind mount volume, ```./server:/app```. It allows us to mount a directory from the host machine to the running container. This can be useful during the development stage when you'd like to make code changes in the host machine and have it reflected to the running container.

 We also used a volume specifically for the ```/app/node_modules``` directory; the reason is to avoid re-installing the dependencies every time the container is recreated. Without a separate volume, the node_modules directory would be part of the container's filesystem, and any changes made to it during the container's runtime would be lost when the container is stopped or removed. By using a volume, the dependencies remain intact and accessible even if the container is restarted or recreated. ```/app/node_modules``` volume ensures that the Node.js application's dependencies are persistent and can be shared across multiple containers or between container lifecycles, reducing the time required for dependency installation and improving overall container performance.

 ### Nginx
 For this multi-container application we need a mechanism to orchestrate the incoming requests and route them to the right service at the backend. For example, we might want to route a request to the react app, and another request to an express app. We'll use Nginx to do so. Here Nginx will act as an upstream server to the architecture. If an incoming request is trying to access an API resource, it'll be routed to the Express server; if not, it'll be routed to the react server. Here we've specified all the routing logic inside the ```nginx/default.conf``` file, which gets copied into the nginx filesystem during the image building proces.