name           = "prod"
vpc_cidr       = "10.1.0.0/16"
public_subnets = ["10.1.1.0/24", "10.1.2.0/24"]
private_subnet = "10.1.10.0/24"
ami_id         = "ami-00ca570c1b6d79f36"
instance_type  = "t3.medium"
key_name       = "prod-key"
instance_count = 2
aws_region     = "ap-south-1"
aws_profile    = "prod-profile"
allowed_ssh_cidr  = ["0.0.0.0/0"]
allowed_http_cidr = ["0.0.0.0/0"]
enable_s3_versioning = true
tags = {
  Environment = "prod"
  Project     = "terraform-iac"
}
