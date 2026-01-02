variable "vpc_cidr" {
  type = string
}
variable "region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "ap-south-1"
}
#Subnets
variable "anywhere_cidr" {
  description = "Anywhere ipv4 cidr"
  type        = string
}
variable "subnet1_cidr" {
  description = "CIDR block for subnet 1"
  type        = string
}
variable "subnet2_cidr" {
  description = "CIDR block for subnet 2"
  type        = string
}
variable "sg_name" {
  description = "Name of Security Group"
  type        = string
}

#Availability Zones
variable "az1" {
  description = "Availability zone for subnet 1"
  type        = string
}
variable "az2" {
  description = "Availability zone for subnet 2"
  type        = string
}

# EC2 Instance details
variable "ami_id" {
  description = "AMI ID for EC2 instances"
  type        = string
}
variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}
variable "userdata1" {
  description = "Path to user data script for webserver1"
  type        = string
}
variable "userdata2" {
  description = "Path to user data script for webserver2"
  type        = string
}
#s3
variable "bucket_name" {
  description = "Name of the S3 Bucket"
  type        = string
}

# Load Balancer
variable "alb_name" {
  description = "Name of the Application Load Balancer"
  type        = string
  default     = "myalb"
}

variable "alb_internal" {
  description = "Whether the ALB is internal"
  type        = bool
  default     = false
}

variable "alb_type" {
  description = "Type of load balancer (application, network, gateway)"
  type        = string
  default     = "application"
}

# Target Group
variable "tg_name" {
  description = "Name of the target group"
  type        = string
  default     = "my-targetgroup"
}
# Listener
variable "http_port" {
  description = "HTTP Port"
  type        = number
  default     = 80
}
variable "ssh_port" {
  description = "SSH Port"
  type        = number
  default     = 22
}

variable "http_protocol" {
  description = "HTTP Protocol"
  type        = string
  default     = "HTTP"
}
variable "tcp_protocol" {
  description = "TCP Protocol"
  type        = string
  default     = "tcp"
}

