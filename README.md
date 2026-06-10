# Flask Application DevOps Project

## Project Overview

This project demonstrates a complete DevOps CI/CD pipeline for deploying a Flask application on AWS using Terraform, Jenkins, Docker, Kubernetes, SonarQube, Route53, and CloudWatch.

The entire deployment process is automated from code commit to production deployment.

---

## Architecture

GitHub
→ Webhook
→ Jenkins Pipeline
→ SonarQube Analysis
→ Docker Build
→ Docker Hub
→ Kubernetes (EKS)
→ Service
→ Ingress
→ AWS Load Balancer
→ Route53 Domain
→ Users

CloudWatch is used for monitoring and logging.

---

## Technologies Used

- AWS EC2
- AWS VPC
- AWS IAM
- AWS Route53
- AWS CloudWatch
- Terraform
- Jenkins
- Docker
- Docker Hub
- Kubernetes (EKS)
- SonarQube
- GitHub
- Shell Scripting
- Flask

---

## Project Structure

```text
flask-app-devops/
│
├── app/
│   ├── app.py
│   ├── requirements.txt
│   └── Dockerfile
│
├── terraform/
│   ├── vpc/
│   ├── securitygroup/
│   ├── ec2/
│   ├── eks/
│   └── module/
│
├── k8s/
│   ├── deployment.yaml
│   ├── service.yaml
│   └── ingress.yaml
│
├── scripts/
│   ├── install_docker.sh
│   ├── install_jenkins.sh
│   └── install_sonarqube.sh
│
├── Jenkinsfile
│
└── README.md
