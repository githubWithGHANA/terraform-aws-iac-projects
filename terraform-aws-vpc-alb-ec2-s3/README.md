# terraform-aws-vpc-alb-ec2-s3
<div align="center">

![GitHub repo size](https://img.shields.io/github/repo-size/githubWithGHANA/terraform-aws-iac-projects?style=flat-square)
![GitHub last commit](https://img.shields.io/github/last-commit/githubWithGHANA/terraform-aws-iac-projects?style=flat-square)
![GitHub](https://img.shields.io/github/license/githubWithGHANA/terraform-aws-iac-projects?style=flat-square)

</div>
Provision a complete AWS infrastructure using Terraform — including VPC, ALB, EC2 instances, and S3 buckets. This module is part of the [`terraform-aws-iac-projects`](https://github.com/githubWithGHANA/terraform-aws-iac-projects.git) repository.

## 🚀 Features

- Custom VPC with public
- Internet Gateway configuration
- Application Load Balancer (ALB) with listener rules
- EC2 instances with user data scripts
- S3 bucket provisioning with versioning
- Centralized tagging strategy

## 📁 Folder Layout
```text
terraform-aws-vpc-alb-ec2-s3/
├── screenshots/
├── backend.tf
├── main.tf
├── output.tf
├── provider.tf
├── terraform.tfvars
├── userdata1.sh
├── userdata2.sh
├── terraform_install.sh
├── variable.tf
└── README.md

```


## 🔧 Prerequisites

- Terraform ≥ 1.3.0
- AWS CLI configured with appropriate IAM permissions


## 🧠 Learning Outcomes

This project helps you gain hands-on experience with:

- Terraform infrastructure lifecycle management
- AWS networking fundamentals (VPC, subnets, IGW)
- Load balancing using Application Load Balancer
- EC2 provisioning and automation with user data
- Terraform state management and backends
- Writing clean, readable, and maintainable Terraform code

---

## 📸 Screenshots

Refer to the `screenshots/` directory for:

- ALB DNS endpoint access
- EC2 instance health checks
- Terraform apply outputs
- And other outcomes 

---

## 👤 Author

**Ghanashyama**  
Aspiring AWS / DevOps Engineer  

GitHub: [githubWithGHANA](https://github.com/githubWithGHANA)
