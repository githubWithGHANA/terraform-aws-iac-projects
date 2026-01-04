terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0.0, < 6.2.0"
    }
  }

  # Optional: enforce Terraform CLI version too
  # required_version = ">= 1.9.0"
}