#!/bin/bash

# IMAGE_NAME="sonu7873/flask-app-devops"
# # IMAGE_TAG=$BUILD_NUMBER

# echo "Building image: $IMAGE_NAME:$IMAGE_TAG"

# docker build -t $IMAGE_NAME:latest -f app/DockerFile app

# echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

# docker push $IMAGE_NAME:$IMAGE_TAG




IMAGE_NAME="sonu7873/flask-app-devops"
IMAGE_TAG="latest"

echo "Checking if image exists: $IMAGE_NAME:$IMAGE_TAG"

if docker manifest inspect $IMAGE_NAME:$IMAGE_TAG > /dev/null 2>&1; then
    echo "Image $IMAGE_NAME:$IMAGE_TAG already exists on Docker Hub."
    echo "Skipping build and push."
    exit 0
fi

echo "Image not found. Building image..."

docker build -t $IMAGE_NAME:$IMAGE_TAG -f app/DockerFile app

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

docker push $IMAGE_NAME:$IMAGE_TAG

echo "Image pushed successfully."