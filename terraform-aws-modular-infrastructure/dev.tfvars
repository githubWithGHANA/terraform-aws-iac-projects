name           = "dev"
vpc_cidr       = "10.0.0.0/16"
public_subnets = ["10.0.1.0/24", "10.0.2.0/24"]
private_subnet = "10.0.10.0/24"
ami_id         = "ami-00ca570c1b6d79f36"
instance_type  = "t3.micro"
key_name       = "dev-key"   #create this key before apply
instance_count = 2
aws_region     = "ap-south-1"
aws_profile    = "dev-profile"
tags = {
  Environment = "dev"
  Project     = "terraform-iac"
}
