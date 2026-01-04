variable "name" {}
variable "vpc_cidr" {}
variable "public_subnets" { type = list(string) }
variable "private_subnet" {}
variable "ami_id" {}
variable "instance_type" {}
variable "key_name" {}
variable "instance_count" { default = 2 }
variable "tags" { type = map(string) }
