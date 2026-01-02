terraform {
  backend "s3" {
    bucket         = "terraform-s3-infra-project"    # must already exist
    key            = "state/terraform.tfstate"      # path inside the bucket
    region         = "ap-south-1"                   # adjust to your AWS region
    encrypt        = true                           # encrypt state at rest
  }
}