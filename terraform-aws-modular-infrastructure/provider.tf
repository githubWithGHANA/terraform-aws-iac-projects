# Configure the AWS Provider
provider "aws" {
  region  = var.aws_region
  profile = var.aws_profile
}


# provider "aws" {
#   region = "ap-south-1"
# }
