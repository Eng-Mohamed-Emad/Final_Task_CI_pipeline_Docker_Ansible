#!/bin/bash

# Define your Docker image name and tag (use Git commit hash or a specific version)
DOCKER_IMAGE_NAME="mohamedemadeldin101/my-weather-app-image"
DOCKER_TAG="latest"  # You can also use Git commit hash as the tag

# If running in Jenkins, credentials will be automatically provided via Jenkins credentials store
# If running locally, we will check if credentials are provided via environment variables

# Check if DOCKER_USERNAME and DOCKER_PASSWORD are set (locally or Jenkins credentials)
if [ -z "$DOCKER_USERNAME" ] || [ -z "$DOCKER_PASSWORD" ]; then
  echo "Docker username or password not provided! Using Docker CLI login credentials."
  # If credentials are not set, use Docker CLI default login (if already logged in on the local machine)
  docker login
else
  echo "Logging in to Docker Hub with provided credentials..."
  echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin
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
