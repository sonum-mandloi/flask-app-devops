#!/bin/bash

IMAGE_NAME="sonu7873/flask-app-devops"
# IMAGE_TAG=$BUILD_NUMBER

echo "Building image: $IMAGE_NAME:$IMAGE_TAG"

docker build -t $IMAGE_NAME:latest -f app/DockerFile app

echo "$DOCKER_PASS" | docker login -u "$DOCKER_USER" --password-stdin

docker push $IMAGE_NAME:$IMAGE_TAG