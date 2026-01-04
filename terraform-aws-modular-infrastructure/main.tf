module "vpc" {
  source         = "./modules/vpc"
  name           = var.name
  vpc_cidr       = var.vpc_cidr
  public_subnets = var.public_subnets
  private_subnet = var.private_subnet
  tags           = var.tags
}

module "ec2" {
  source             = "./modules/ec2"
  name               = var.name
  ami_id             = var.ami_id
  instance_type      = var.instance_type
  subnet_ids         = module.vpc.public_subnet_ids
  security_group_ids = [aws_security_group.web_sg.id]
  key_name           = var.key_name
  instance_count     = var.instance_count
  
  # 👇 USER DATA FILES
  user_data_files = [
    "${path.module}/userdata/userdata-server-1.sh",
    "${path.module}/userdata/userdata-server-2.sh"
  ]
  tags               = var.tags
}
# Web EC2 SG
resource "aws_security_group" "web_sg" {
  name        = "${var.name}-web-sg"
  description = "Security group for EC2 instances"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-web-sg" }
  )
}

# ALB SG
resource "aws_security_group" "alb_sg" {
  name        = "${var.name}-alb-sg"
  description = "Security group for ALB"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = merge(
    var.tags,
    { Name = "${var.name}-alb-sg" }
  )
}

module "alb" {
  source              = "./modules/alb"
  name                = var.name
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnet_ids
  security_group_ids  = [aws_security_group.alb_sg.id]
  target_instance_ids = module.ec2.instance_ids
  tags                = var.tags
}

module "s3" {
  source     = "./modules/s3"
  name       = var.name
  tags       = var.tags
  versioning = true
}
