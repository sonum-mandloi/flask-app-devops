#!/bin/bash

set -ex
 
# Log everything
exec > /var/log/user-data.log 2>&1

apt update -y

# Git
apt install git -y

# Docker
apt install docker.io -y
systemctl start docker
systemctl enable docker
usermod -aG docker ubuntu

# Java
sudo apt update
sudo apt install fontconfig openjdk-21-jre -y
java --version

sudo wget -O /etc/apt/keyrings/jenkins-keyring.asc \
  https://pkg.jenkins.io/debian-stable/jenkins.io-2026.key
echo "deb [signed-by=/etc/apt/keyrings/jenkins-keyring.asc]" \
  https://pkg.jenkins.io/debian-stable binary/ | sudo tee \
  /etc/apt/sources.list.d/jenkins.list > /dev/null
sudo apt update
sudo apt install jenkins -y

sudo usermod -aG docker jenkins
sudo  systemctl restart jenkins
sudo   systemctl restart docker

# EKS and Kubectl

echo "Updating packages..."
sudo apt update -y

echo "Installing required packages..."
sudo apt install -y curl wget tar

# Install kubectl
echo "Installing kubectl..."
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

# Install eksctl
echo "Installing eksctl..."
ARCH=amd64
PLATFORM=$(uname -s)_$ARCH

curl -sLO "https://github.com/eksctl-io/eksctl/releases/latest/download/eksctl_$${PLATFORM}.tar.gz"

tar -xzf eksctl_$${PLATFORM}.tar.gz
sudo mv eksctl /usr/local/bin/

# cloud watch agent
sudo apt update

sudo apt install amazon-cloudwatch-agent -y
