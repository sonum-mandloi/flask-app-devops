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
```
---
## Prerequisites

Before starting, ensure you have:

  AWS Account
  AWS CLI configured
  Terraform installed
  Docker installed
  kubectl installed
  Jenkins Server
  SonarQube Server
  Docker Hub Account
  GitHub Repository

## Step 1: Clone Repository

```
  git clone https://github.com/your-username/flask-app-devops.git

  cd flask-app-devops
 ```

---

## Step 2: Create AWS Infrastructure Using Terraform

Navigate to Terraform directory:

``` cd terraform/module```

Initialize Terraform:

``` terraform init```

Validate configuration:

``` terraform validate```

Preview infrastructure:

``` terraform plan```

Create infrastructure:

``` terraform apply -auto-approve```

Resources created:

  VPC,
  Public Subnets,
  Security Groups,
  EC2 Instance,
  IAM Roles,
  EKS Cluster,
  Worker Nodes,
  
---

## Step 3: Configure Jenkins

Install Jenkins on EC2.

Access Jenkins:

``` http://<jenkins-public-ip>:8080```
Configure:

  JDK
  Git
  Docker
  SonarQube Scanner
  AWS Credentials

---

## Step 4: Configure SonarQube

Run SonarQube using Docker:

```  docker run -d --name sonarqube -p 9000:9000 sonarqube:lts-community```

Access:
``` http://<server-ip>:9000```

Create:

  SonarQube Project
  Token

Add token to Jenkins credentials.

---

## Step 5: Build Docker Image

Build image:
``` docker build -t flask-app .```

Test image:
```d ocker run -p 5000:5000 flask-app```

Push image:
```
  docker tag flask-app username/flask-app:latest

  docker push username/flask-app:latest
```

---
## Step 6: Configure GitHub Webhook

GitHub Repository

Settings → Webhooks

Payload URL:

```
  http://<jenkins-public-ip>:8080/github-webhook/
```

Content Type:

  ```application/json```

Now every code push triggers Jenkins automatically.

---

## Step 7: Configure Jenkins Pipeline

Create Pipeline Job.

Use Jenkinsfile from repository.

Pipeline stages:

  Git Clone
  SonarQube Analysis
  Docker Build
  Docker Push
  Kubernetes Deployment

---

## Step 8: Deploy Application to Kubernetes

Apply Deployment:

  ```kubectl apply -f deployment.yaml```

Apply Service:

  ```kubectl apply -f service.yaml```

Apply Ingress:

  ```kubectl apply -f ingress.yaml```

Verify resources:

   ```
    kubectl get pods
    
    kubectl get svc
    
    kubectl get ingress
    ```

---

## Step 9: Configure Route53

Create Hosted Zone.

Create A Record.

Map:

  ```app.yourdomain.com```

to:

  ```AWS Load Balancer DNS```

---

## Step 10: Monitoring Using CloudWatch

CloudWatch monitors:
    EC2
    EKS
    Application Logs
    Container Logs
    Metrics

Verify:
   AWS Console → CloudWatch

---

## CI/CD Workflow
  Developer pushes code to GitHub
  GitHub Webhook triggers Jenkins
  Jenkins clones repository
  SonarQube analyzes code quality
  Docker image is built
  Image pushed to Docker Hub
  Kubernetes deployment updated
  Load Balancer serves application
  Route53 routes domain traffic
  CloudWatch monitors infrastructure

---

## Features
  Infrastructure as Code (Terraform)
  CI/CD Automation
  Docker Containerization
  Kubernetes Orchestration
  Automated Deployment
  Route53 DNS Mapping
  CloudWatch Monitoring
  GitHub Webhook Integration
  SonarQube Code Quality Checks
