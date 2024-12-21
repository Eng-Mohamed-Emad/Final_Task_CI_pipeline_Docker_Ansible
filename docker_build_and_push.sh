#!/bin/bash

# Define your Docker image name and tag (use Git commit hash or a specific version)
DOCKER_IMAGE_NAME="mohamedemadeldin101/my-weather-app-image"
DOCKER_TAG="latest"  # You can also use Git commit hash as the tag

# Log in to Docker Hub
echo "Logging in to Docker Hub..."
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin



# Build the Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .

# Push the Docker image to Docker Hub
echo "Pushing Docker image to Docker Hub..."
docker push $DOCKER_IMAGE_NAME:$DOCKER_TAG

# Check if the push was successful
if [ $? -eq 0 ]; then
  echo "Docker image pushed successfully!"
else
  echo "Docker image push failed!"
  exit 1
fi
