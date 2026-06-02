resource "aws_instance" "jenkins_server" {
  ami           = var.i_image
  instance_type = var.i_type
  key_name      = var.key_name

  subnet_id              = var.public_subnet_1
  vpc_security_group_ids = [var.sg_id]

  tags = {
    Name = "Jenkins-Server"
  }

  user_data = <<-EOF
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
EOF
}