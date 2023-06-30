#!/bin/bash

# Remove any existing Docker image and container
docker stop react-app-container
docker rm react-app-container
docker rmi react-app-image

# Build the Docker image
docker build -t myapp .

# Run the Docker container
docker run -d -p 80:80 --name react-app-container myapp
