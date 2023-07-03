#!/bin/bash

# Variables
IMAGE_NAME="mdazar1998/capstone-project-dev-repo:latest"
CONTAINER_NAME="React-Container"

# Check if the container is already running
if [[ "$(docker ps -aq -f name=${CONTAINER_NAME})" ]]; then
    #"Stopping and removing existing container..."
    sudo docker stop ${CONTAINER_NAME}
    sudo docker rm ${CONTAINER_NAME}
fi
# Authenticate with Docker Hub
# Set the Docker Hub credentials
DOCKER_USERNAME="mdazar1998"
DOCKER_PASSWORD="dckr_pat_Ep7uStBzLwfy-vPjn81QruO3vvI"

echo "$DOCKER_PASSWORD" | docker login --username "$DOCKER_USERNAME" --password-stdin

# Pull the image
sudo docker pull ${IMAGE_NAME}

# Run the container
sudo docker run -d --name ${CONTAINER_NAME} -p 80:80  ${IMAGE_NAME}
sudo docker logout
