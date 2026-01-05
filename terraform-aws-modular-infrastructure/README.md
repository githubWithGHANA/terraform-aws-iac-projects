<div align="center">

<h1>Terraform AWS Modular Infrastructure (VPC + EC2 + ALB + S3)</h1>

</div>

<div align="center">

![GitHub repo size](https://img.shields.io/github/repo-size/githubWithGHANA/terraform-aws-iac-projects?style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/githubWithGHANA/terraform-aws-iac-projects?style=flat-square)
![GitHub](https://img.shields.io/github/license/githubWithGHANA/terraform-aws-iac-projects?style=flat-square)

</div>

## 📌 Project Overview
This project demonstrates a **production-style, modular Terraform architecture** on AWS using best practices. It provisions a complete infrastructure stack with **environment separation (dev / test / prod)**, **remote state management**, **state locking**, and **clean module boundaries**.

---

## 🏗️ Architecture Overview

**High-level flow:**

- VPC with public & private networking
- EC2 instances deployed in public subnets
- Application Load Balancer distributing traffic
- S3 bucket for shared storage
- Remote backend with S3 + DynamoDB locking

### 🔧 Core Components
- **VPC**
  - 2 Public Subnets
  - 1 Private Subnet
  - Internet Gateway (IGW)
  - NAT Gateway
  - Public & Private Route Tables

- **EC2**
  - 2 EC2 instances
  - One instance per public subnet
  - IMDSv2 enabled via user-data
  - Apache installed and auto-configured

- **ALB**
  - Application Load Balancer
  - Target Group with EC2 instances
  - HTTP Listener (Port 80)

- **S3**
  - Versioning enabled
  - Public access blocked

- **Backend**
  - S3 remote state (versioned)
  - DynamoDB state locking

---
## 📊 Architecture Diagram

This diagram illustrates the Terraform-provisioned AWS infrastructure:

<img width="1400" height="788" alt="image" src="https://github.com/user-attachments/assets/5b1964fb-6e9b-49fc-a78d-158eb42d950f" />

---

## 📁 Project Layout

```text
terraform-aws-modular-infrastructure/
│
├── backend.tf                # Remote backend (S3 + DynamoDB lock)
├── provider.tf               # AWS provider configuration
├── version.tf                # Terraform & provider versions
├── main.tf                   # Root module wiring (calls child modules)
├── variables.tf              # Root-level variables
├── outputs.tf                # Root-level outputs
│
├── dev.tfvars                # Dev environment variables
├── test.tfvars               # Test environment variables
├── prod.tfvars               # Prod environment variables
│
├── userdata/                 # EC2 user-data scripts
│   ├── userdata-server-1.sh
│   └── userdata-server-2.sh
│
├── modules/                  # Reusable Terraform modules
│   │
│   ├── vpc/
│   │   ├── main.tf           # VPC, subnets, IGW, NAT, route tables
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── ec2/
│   │   ├── main.tf           # EC2 instances (public subnets + userdata)
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── alb/
│   │   ├── main.tf           # ALB, listener, target group, attachments
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── s3/
│       ├── main.tf           # S3 bucket (versioning + public block)
│       ├── variables.tf
│       └── outputs.tf
│
├── README.md                 # Full project documentation
│
└── .terraform/               # Terraform working directory (auto-generated)

```

---

## 🔐 Remote Backend Configuration

### backend.tf (single file – environment switching via key)

```hcl
terraform {
  backend "s3" {
    bucket         = "your-unique-terraform-state-bucket"
    key            = "dev/terraform.tfstate" # change per environment
    region         = "ap-south-1"
    dynamodb_table = "terraform-state-lock"
    encrypt        = true
  }
}
```

### Environment-specific keys

```hcl
# dev
key = "dev/terraform.tfstate"

# test
# key = "test/terraform.tfstate"

# prod
# key = "prod/terraform.tfstate"
```

👉 **Only one key must be active at a time**

---

## 🔒 DynamoDB Lock Table

- Prevents concurrent Terraform operations
- Required for team/CI usage

```text
Table name : terraform-state-lock
Partition  : LockID (String)
```

---

## 🌍 Environment Management (tfvars)

Each environment has its own variable file:

- `dev.tfvars`
- `test.tfvars`
- `prod.tfvars`

Example:

```hcl
name           = "dev"
vpc_cidr      = "10.0.0.0/16"
instance_type = "t3.micro"
```

---

## 🚀 How to Deploy

### 1️⃣ Initialize Terraform

```bash
terraform init -reconfigure
```

### 2️⃣ Validate

```bash
terraform validate
```

### 3️⃣ Plan (example: dev)

```bash
terraform plan -var-file=dev.tfvars
```

### 4️⃣ Apply

```bash
terraform apply -var-file=dev.tfvars
```

### 5️⃣ Destroy

```bash
terraform destroy -var-file=dev.tfvars
```

---

## ⚠️ Mandatory Checks Before Apply

### ✅ AMI
- Ensure the AMI ID is **valid for your region**
- Amazon Linux 2023 recommended

### ✅ Key Pair
- SSH key pair **must already exist** in AWS

### ✅ S3 Bucket
- Bucket name **must be globally unique**

### ✅ Region & AZs
- Ensure region and AZs exist in your account

---

## 🔁 Environment Switching (Correct Process)

1. Update backend key in `backend.tf`
2. Run:

```bash
terraform init -reconfigure
```

3. Use matching tfvars file

```bash
terraform apply -var-file=prod.tfvars
```

❌ Never mix `dev.tfvars` with `prod` backend key

---

## 🧠 Design Decisions (Why This Architecture)

- **Modules** → Reusable & maintainable
- **Remote backend** → Team-safe & CI/CD ready
- **State locking** → Prevents corruption
- **IMDSv2** → AWS security best practice
- **No hardcoding** → Environment portability

---

## 🧪 Tested With

- Terraform ≥ 1.5
- AWS Provider ≥ 5.x
- Amazon Linux 2023

---

## 👤 Author

**Ghanashyama**  
Cloud & DevOps Enthusiast  
Terraform | AWS | IaC

---

## ⭐ Final Notes

This project reflects **real-world Terraform usage**, not lab-only examples. The structure, backend strategy, and environment isolation are aligned with **industry expectations** and **DevOps interviews**.

> "Same code, different state, different environment."

