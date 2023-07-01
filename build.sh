#!/bin/bash

#Build the Docker image
docker build -t myapp:$1 .
# git trigger
# Run the Docker container
# docker run -d -p 80:80 --name react-app-container myapp
