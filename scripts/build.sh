#!/bin/bash

IMAGE_NAME="sonu7873/flask-app-devops"
IMAGE_TAG=$BUILD_NUMBER

echo "Building image: $IMAGE_NAME:$IMAGE_TAG"

docker build -t $IMAGE_NAME:$IMAGE_TAG -f app/DockerFile 

docker push $IMAGE_NAME:$IMAGE_TAG