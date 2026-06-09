#!/bin/bash

set -ex

# Log file
exec > /var/log/user-data.log 2>&1

# Update packages
apt update -y

# Install Docker
apt install -y docker.io

# Start and enable Docker
systemctl start docker
systemctl enable docker

# Add ubuntu user to docker group
usermod -aG docker ubuntu

# Pull SonarQube image
docker pull sonarqube:lts-community

# Create SonarQube container
docker run -d \
  --name sonarqube \
  -p 9000:9000 \
  --restart unless-stopped \
  sonarqube:lts-community

  