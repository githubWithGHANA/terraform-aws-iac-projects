#VPC
vpc_cidr = "192.168.0.0/16"

subnet1_cidr  = "192.168.1.0/24"
subnet2_cidr  = "192.168.2.0/24"
anywhere_cidr = "0.0.0.0/0"

sg_name = "websg"
az1     = "ap-south-1a"
az2     = "ap-south-1b"

ami_id        = "ami-00ca570c1b6d79f36"
instance_type = "t3.micro"
userdata1    = "userdata1.sh"
userdata2    = "userdata2.sh"

bucket_name = "terraform-s3-infra-project"

alb_name     = "myalb"
alb_internal = false
alb_type     = "application"

tg_name       = "my-targetgroup"
http_port     = 80
ssh_port      = 22
http_protocol = "HTTP"
tcp_protocol  = "tcp"
