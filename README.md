# IT Tools Platform on AWS (ECS Fargate, Terraform, CI/CD)

![AWS](https://img.shields.io/badge/AWS-232F3E?logo=amazonaws&logoColor=white)
![ECS Fargate](https://img.shields.io/badge/ECS_Fargate-FF9900?logo=amazonecs&logoColor=white)
![Terraform](https://img.shields.io/badge/Terraform-844FBA?logo=terraform&logoColor=white)
![IaC](https://img.shields.io/badge/IaC-7B42BC)
![GitHub Actions](https://img.shields.io/badge/GitHub_Actions-2088FF?logo=githubactions&logoColor=white)
![CI/CD](https://img.shields.io/badge/CI%2FCD-0078D4)
![Docker](https://img.shields.io/badge/Docker-2496ED?logo=docker&logoColor=white)
![Containers](https://img.shields.io/badge/Containers-2496ED)
![Security](https://img.shields.io/badge/Security-DC3545)
![OIDC](https://img.shields.io/badge/OIDC-28A745)
![IAM](https://img.shields.io/badge/IAM-FF9900)
![Least Privilege](https://img.shields.io/badge/Least_Privilege-DC3545)

## Project Overview

This project deploys a containerised IT Tools application to Amazon ECS Fargate using Terraform for Infrastructure as Code (IaC). The solution utilises GitHub Actions for CI/CD, Amazon ECR for container image storage, Route 53 for DNS management, and AWS Certificate Manager for HTTPS encryption. The infrastructure is designed using secure Multi-AZ architecture with public and private subnets.

---

## Application URL
→ https://tools.osmanhus.co.uk

![Live App](assets/live-application.png)

---

## Local Setup

Run the containerised IT Tools application locally using Docker.

**Build the Docker image:**

```sh
docker build -t it-tools ./app
```

**Run the container locally:**

```sh
docker run -d --name it-tools --restart unless-stopped -p 8080:80 it-tools
```

Access the application locally at `http://localhost:8080`.

## Architecture Diagram

<!-- Architecture diagram will be added here -->

---

## Features
- Infrastructure provisioned using **Terraform**
- Remote Terraform state stored in **Amazon S3 Bucket**
- Custom **VPC** with two Public and Private Subnets spanning Multiple Availability Zones
- Container image build, vulnerability scanning, and storage using **Amazon ECR**
- **ECS Fargate Service** behind ALB and HTTPS enabled using **AWS Certificate Manager (ACM)**
- Custom Domain configured using **Route 53**
- Automated Container image build/push and deployment using **GitHub Actions**
- **GitHub Actions** authentication using **AWS OIDC** (no long-lived AWS credentials)

---

## Repository Structure
```
.
├── .github/
│   └── workflows/
│       ├── build.yml
│       ├── deploy.yml
│       └── destroy.yml
├── app/
│   ├── Dockerfile
│   ├── nginx.conf
│   └── app source code
│
├── bootstrap/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   └── variables.tf
│
├── infra/
│   ├── main.tf
│   ├── outputs.tf
│   ├── provider.tf
│   ├── variables.tf
│   └── modules/
│       ├── acm/
│       ├── alb/
│       ├── ecs/
│       └── vpc/
├── assets/
│   ├── build-and-push.png
│   ├── docker-image-comparison.png
│   ├── live-application.png
│   ├── terraform-deploy.png
│   └── terraform-destroy.png
├── .gitignore
└── README.md
```

---

## Key Components

### Dockerfile
- Implemented **non-root** user access to limit root access and enhance security
- Introduced **multi-stage Dockerfile**, reducing image size by **87%**
    - Docker image size comparison:
    ![](assets/docker-image-comparison.png)

### Infrastructure
- **VPC (Virtual Private Cloud)** - Provides secure network isolation for all AWS resources
- **Public Subnets** - Hosts internet-facing resources, such as **ALB** and **NAT Gateway**
- **Private Subnets** - Hosts **ECS Fargate Tasks**, preventing direct access from the internet
- **Internet Gateway** - Enables communication between public AWS resources and the internet
- **NAT Gateway** - Enables resources within private subnets to initiate outbound internet access while blocking direct inbound access from the internet
- **ALB (Application Load Balancer)** - Distributes incoming traffic evenly across **ECS Tasks** and handles HTTPS traffic using **ACM certificate**
- **ECS Fargate** - Serverless compute engine running the containerised application
- **Amazon ECR** - Stores container image used by **ECS service**
- **Route 53** - Provides **DNS management** and routes traffic from custom domain to **ALB**
- **ACM (AWS Certificate Manager)** - Manages SSL/TLS certificates needed to enable **HTTPS** encryption for secure application traffic
- **S3 Backend** - Stores Terraform remote state with native state locking enabled

### Workflows
- **GitHub Actions** - Continuous Integration and Continuous Delivery **(CI/CD)** platform used to automate container builds, infrastructure deployments, and resource teardown
    - **Build and Push Workflow** - Builds image for the app, runs a security scan for vulnerabilities, and pushes image to ECR
    - **Terraform Deploy Workflow** - Initialises, Plans and Applies infrastructure. Infrastructure security scanning and post deploy health checks are completed within the workflow
    - **Terraform Destroy Workflow** - Safely removes all resources managed by Terraform when no longer needed

### Security
- **IAM Roles** - Permissions follow the principle of least privilege, granting only the access required for GitHub Actions and ECS operations
- **GitHub OIDC Authentication** - Allows GitHub Actions to securely assume **IAM roles** without storing any long-term AWS credentials
- **Infrastructure Security Scanning** - Scans Terraform configuration for security issues before infrastructure deployment
- **Container Vulnerability Scanning** - Scans container images for vulnerabilities before pushing them to **Amazon ECR**

---

## CI/CD Pipelines

### 1) Build and Push to ECR
![Build and Push](assets/build-and-push.png)


### 2) Deploy and Post Health Check
![Deploy](assets/terraform-deploy.png)


### 3) Destroy Infrastructure
![Destroy](assets/terraform-destroy.png)

---

## Lessons Learned
- **GitHub OIDC Authentication** - Initially, I considered using AWS access keys within my GitHub Actions. After researching authentication methods, I implemented OIDC instead, allowing the workflow to assume an IAM role using temporary credentials generated at runtime. This eliminates the need to store long-lived AWS credentials within GitHub, significantly reducing the risk of credential exposure.

- **IAM Permissions** - While testing my Terraform Destroy workflow, the pipeline failed because the GitHub Actions role was missing the `iam:ListInstanceProfilesForRole` permission. Troubleshooting the 403 AccessDenied error and updating the IAM policy helped me understand the importance of ensuring least-privilege permissions cover both infrastructure deployment and resource teardown.

- **Route 53 DNS Delegation** - My domain was already managed through Cloudflare, while I wanted the application DNS managed through Amazon Route 53. I delegated the `tools.osmanhus.co.uk` subdomain using NS records in Cloudflare, allowing Route 53 to manage the application record and ACM certificate validation without transferring management of the entire domain.
