#!/bin/bash

# Define your Docker image name and tag (use Git commit hash or a specific version)
DOCKER_IMAGE_NAME="mohamedemadeldin101/my-weather-app-image"
DOCKER_TAG="latest"  # You can also use Git commit hash as the tag

# Check if running in Jenkins, credentials will be automatically provided
if [ -n "$myuser" ] && [ -n "$mypass" ]; then
  # Jenkins environment variables will have the credentials
  echo "Logging in to Docker Hub with provided credentials..."
  echo "$mypass" | docker login -u "$myuser" --password-stdin
else
  # If credentials are not set, use Docker CLI default login (local machine login)
  echo "Docker username or password not provided in Jenkins environment. Attempting local Docker login."
  docker login
fi

# Check if login was successful
if [ $? -ne 0 ]; then
  echo "Docker login failed!"
  exit 1
fi

# Build the Docker image
echo "Building Docker image..."
docker build -t $DOCKER_IMAGE_NAME:$DOCKER_TAG .

# Check if the build was successful
if [ $? -ne 0 ]; then
  echo "Docker image build failed!"
  exit 1
fi

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
