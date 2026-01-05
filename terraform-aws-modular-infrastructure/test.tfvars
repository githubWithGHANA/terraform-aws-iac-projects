name           = "test"
vpc_cidr       = "10.2.0.0/16"
public_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnet = "10.2.10.0/24"
ami_id         = "ami-00ca570c1b6d79f36"
instance_type  = "t3.small"
key_name       = "test-key"
instance_count = 2
aws_region     = "ap-south-1"
aws_profile    = "test-profile"
allowed_ssh_cidr  = ["0.0.0.0/0"]
allowed_http_cidr = ["0.0.0.0/0"]
enable_s3_versioning = true
tags = {
  Environment = "test"
  Project     = "terraform-iac"
}
