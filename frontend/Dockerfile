# All steps
# 1: Run the npm run build command inside an alpine image 
# 2: Create a second container that runs on Nginx 
# 3: Copy the build folder created in the fist step into Nginx 

# Build
FROM node:16-alpine as builder
WORKDIR /app 
COPY ./package.json ./
RUN npm install 
COPY ./ ./ 
CMD ["npm", "run", "build"]

# Run
FROM nginx
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
