variable "name" {
  description = "Resource name prefix used across all modules"
}

variable "vpc_cidr" {
  description = "CIDR block for creating the VPC"
}

variable "public_subnets" {
  type        = list(string)
  description = "List of CIDR blocks for public subnets"
}

variable "private_subnet" {
  description = "CIDR block for the private subnet"
}

variable "ami_id" {
  description = "AMI ID used for EC2 instances"
}

variable "instance_type" {
  description = "EC2 instance type (e.g., t2.micro, t3.micro)"
}

variable "key_name" {
  description = "Existing AWS key pair name for SSH access"
}

variable "instance_count" {
  default     = 2
  description = "Number of EC2 instances to create (default is 2)"
}

variable "aws_region" {
  description = "AWS region where resources will be deployed"
}

variable "aws_profile" {
  description = "AWS CLI profile used for authentication"
}

variable "allowed_ssh_cidr" {
  description = "CIDR allowed for SSH"
  type        = list(string)
}

variable "allowed_http_cidr" {
  description = "CIDR allowed for HTTP"
  type        = list(string)
}

variable "enable_s3_versioning" {
  description = "Enable S3 versioning"
  type        = bool
}

variable "tags" {
  type        = map(string)
  description = "Common tags applied to all AWS resources"
}

