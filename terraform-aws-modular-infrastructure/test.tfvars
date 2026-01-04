name           = "test"
vpc_cidr       = "10.2.0.0/16"
public_subnets = ["10.2.1.0/24", "10.2.2.0/24"]
private_subnet = "10.2.10.0/24"
ami_id         = "ami-0abcdef123456"
instance_type  = "t2.micro"
key_name       = "test-key"
instance_count = 2
aws_region     = "ap-south-1"
aws_profile    = "test-profile"
tags = {
  Environment = "test"
  Project     = "terraform-iac"
}
