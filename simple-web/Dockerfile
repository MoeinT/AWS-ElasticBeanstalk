# Specify the Base Image
FROM node:14-alpine
# Specify the working directory
WORKDIR /usr/app
# Copy the Package.json file into the container's namespace
COPY ./package.json ./
# Install the dependencies specified in the package.json file
RUN npm install
# Copy every other file
COPY ./ ./
# Run the default command to run the server when the container is starting
CMD ["npm", "start"]