#!/bin/bash

# Load environment variables from .env file
set -o allexport
source .env.docker
set +o allexport

# Get current date and time formatted as YYYYMMDD-HHMM
currentDateTime=$(date +"%Y%m%d-%H%M")

# Define the Docker image name
imageName="shashidas/todo-frontend:$currentDateTime"

# Build the Docker image and tag it
docker build -t "$imageName" .

# Log in to Docker Hub using credentials from the .env file
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

# Push the image to Docker Hub
docker push "$imageName"
