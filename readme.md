# Installation

Run the following command to clone the repository

```
git clone https://github.com/shashidas95/todo.git
```

Go to `frontend` and `backend` directory to install packages !!!

```
cd frontend
npm install
```

```
cd backend
npm install
```

# Configuration

Create `.env` file inside `backend` directory and copy the following code

```
MONGO_URI=Your mongodb URI
GMAIL_USERNAME=your gmail address
GMAIL_PASSWORD=password created inside 'App Password' section under google accounts setting
PORT=8000
JWT_SECRET=a random secret key eg. thisisasecretkey
```

# Run the App

Go to `backend` and `frontend` directory and start the server

```
cd backend
nodemon server
```

```
cd frontend
npm start
```
---

# 🚀 Enterprise MERN DevOps Platform
### Production-Grade CI/CD | Kubernetes | AWS | Terraform

A fully production-ready MERN application deployed using modern DevOps practices including:

- Docker containerization
- Jenkins CI/CD automation
- Kubernetes orchestration (EKS-ready)
- AWS cloud deployment
- Terraform Infrastructure as Code

This project demonstrates enterprise-level DevOps architecture suitable for real-world production systems.

---

# 📌 Project Highlights (Resume Ready)

✔ End-to-end CI/CD pipeline using Jenkins  
✔ Containerized microservice architecture  
✔ Kubernetes production deployment  
✔ AWS cloud infrastructure  
✔ Infrastructure as Code using Terraform  
✔ Scalable and highly available system design  
✔ DevOps best practices implementation  

---

# 🛠 Tech Stack

| Layer | Technology |
|--------|------------|
| Frontend | React.js |
| Backend | Node.js + Express.js |
| Database | MongoDB |
| Containerization | Docker |
| CI/CD | Jenkins |
| Orchestration | Kubernetes |
| Cloud | AWS (EC2 / EKS / ECR) |
| IaC | Terraform |

---

# 🏗 Enterprise Architecture Overview


```
            Developer
                │
                ▼
            GitHub Repo
                │ (Webhook)
                ▼
            Jenkins Server
        (Build → Test → Dockerize)
                │
                ▼
          Docker Registry (ECR)
                │
                ▼
       AWS EKS Kubernetes Cluster
    ┌────────────────────────────┐
    │ Frontend Deployment        │
    │ Backend Deployment         │
    │ MongoDB (or AWS RDS)       │
    └────────────────────────────┘
                │
                ▼
       AWS Load Balancer (ALB)
                │
                ▼
              Users
```


---

# 📂 Enterprise Folder Structure

```

mern-enterprise-devops/
│
├── backend/
├── frontend/
├── k8s/
│   ├── backend-deployment.yaml
│   ├── frontend-deployment.yaml
│   ├── services.yaml
│   └── ingress.yaml
│
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── vpc.tf
│   ├── ec2.tf
│   ├── eks.tf
│   └── security-groups.tf
│
├── Jenkinsfile
├── docker-compose.yml
└── README.md

````

---

# 🔁 Enterprise CI/CD Pipeline

## Pipeline Flow

1. Developer pushes code
2. GitHub webhook triggers Jenkins
3. Jenkins:
   - Installs dependencies
   - Runs tests
   - Builds Docker images
   - Pushes images to AWS ECR
   - Deploys to Kubernetes
4. Kubernetes performs rolling update
5. Application becomes live via LoadBalancer

---

## Example Jenkinsfile (Production Style)

```groovy
pipeline {
  agent any

  environment {
    REGISTRY = "your-ecr-repo"
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/your-repo.git'
      }
    }

    stage('Build Backend Image') {
      steps {
        sh 'docker build -t $REGISTRY/backend ./backend'
      }
    }

    stage('Push Image') {
      steps {
        sh 'docker push $REGISTRY/backend'
      }
    }

    stage('Deploy to Kubernetes') {
      steps {
        sh 'kubectl apply -f k8s/'
      }
    }
  }
}
````

---

# 🏗 Kubernetes Production Deployment

## Key Production Features

* ReplicaSets for high availability
* Rolling updates enabled
* Resource limits configured
* Kubernetes Secrets used
* Ingress with LoadBalancer
* Horizontal Pod Autoscaler ready

Example resource configuration:

```yaml
resources:
  requests:
    memory: "256Mi"
    cpu: "200m"
  limits:
    memory: "512Mi"
    cpu: "500m"
```

Deploy:

```bash
kubectl apply -f k8s/
```

---

# ☁️ AWS Infrastructure (Terraform IaC)

## Terraform Architecture

* VPC
* Public & Private Subnets
* Internet Gateway
* Security Groups
* EC2 (Jenkins)
* EKS Cluster
* Node Groups

---

## terraform/main.tf

```hcl
provider "aws" {
  region = var.region
}
```

---

## terraform/variables.tf

```hcl
variable "region" {
  default = "ap-south-1"
}

variable "instance_type" {
  default = "t2.micro"
}
```

---

## terraform/vpc.tf

```hcl
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"
}
```

---

## terraform/ec2.tf (Jenkins Server)

```hcl
resource "aws_instance" "jenkins" {
  ami           = "ami-xxxxxxxx"
  instance_type = var.instance_type
  tags = {
    Name = "Jenkins-Server"
  }
}
```

---

## terraform/eks.tf (Simplified Example)

```hcl
resource "aws_eks_cluster" "mern_cluster" {
  name     = "mern-cluster"
  role_arn = aws_iam_role.eks_role.arn
}
```

---

## Deploy Infrastructure

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

---

# 📊 DevOps Architecture Diagram (Enterprise Level)

```
        ┌──────────────────────────────┐
        │        Developer             │
        └──────────────┬───────────────┘
                       ▼
        ┌──────────────────────────────┐
        │           GitHub             │
        └──────────────┬───────────────┘
                       ▼
        ┌──────────────────────────────┐
        │          Jenkins EC2         │
        │   CI/CD Automation Server    │
        └──────────────┬───────────────┘
                       ▼
        ┌──────────────────────────────┐
        │        AWS ECR Registry      │
        └──────────────┬───────────────┘
                       ▼
        ┌──────────────────────────────┐
        │        AWS EKS Cluster       │
        │  ┌──────────┬────────────┐  │
        │  │Frontend  │ Backend    │  │
        │  │Pods      │ Pods       │  │
        │  └──────────┴────────────┘  │
        └──────────────┬───────────────┘
                       ▼
        ┌──────────────────────────────┐
        │        AWS Load Balancer     │
        └──────────────┬───────────────┘
                       ▼
                     Users
```

---

# 🚀 Enterprise Best Practices Implemented

* Multi-stage Docker builds
* Infrastructure as Code
* Immutable container deployments
* Rolling updates
* Cloud-native architecture
* Separation of concerns
* Production-grade CI/CD
* Security group isolation
* Horizontal scalability

---

# 🎯 Why This Project is Resume-Ready

This project demonstrates:

* Real-world DevOps lifecycle
* Cloud-native deployment
* Kubernetes production knowledge
* CI/CD automation expertise
* Terraform infrastructure provisioning
* Scalable system architecture design

---

# 👨‍💻 Author

Shashi Kanta Das
DevOps Engineer | Kubernetes | AWS | CI/CD | Terraform


---

# Live Preview 333

Check live preview here [https://todo-app-b96a5.web.app/](https://todo-app-b96a5.web.app/)
