resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr
}
resource "aws_subnet" "subnet1" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet1_cidr
  availability_zone       = var.az1
  map_public_ip_on_launch = true
}
resource "aws_subnet" "subnet2" {
  vpc_id                  = aws_vpc.myvpc.id
  cidr_block              = var.subnet2_cidr
  availability_zone       = var.az2
  map_public_ip_on_launch = true
}
#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.myvpc.id
}
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = var.anywhere_cidr
    gateway_id = aws_internet_gateway.igw.id
  }
}
resource "aws_route_table_association" "pub-rt-1" {
  subnet_id      = aws_subnet.subnet1.id
  route_table_id = aws_route_table.route_table.id
}
resource "aws_route_table_association" "pub-rt-2" {
  subnet_id      = aws_subnet.subnet2.id
  route_table_id = aws_route_table.route_table.id
}

#Security groups
resource "aws_security_group" "websg" {
  name   = var.sg_name
  vpc_id = aws_vpc.myvpc.id
  ingress {
    description = "HTTP from VPC"
    from_port   = var.http_port
    to_port     = var.http_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.anywhere_cidr]
  }
  ingress {
    description = "SSH from VPC"
    from_port   = var.ssh_port
    to_port     = var.ssh_port
    protocol    = var.tcp_protocol
    cidr_blocks = [var.anywhere_cidr]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = [var.anywhere_cidr]
  }
  tags = {
    Name = "Web-SG"
  }
}
#S3
resource "aws_s3_bucket" "s3-tf-state" {
  bucket = var.bucket_name
}
resource "aws_s3_bucket_versioning" "tf_state_versioning" {
  bucket = aws_s3_bucket.s3-tf-state.id

  versioning_configuration {
    status = "Enabled"
  }
}


# Creating Ec2-instance with the VPC
resource "aws_instance" "webserver1" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id              = aws_subnet.subnet1.id
  user_data              = base64encode(file(var.userdata1))
}

resource "aws_instance" "webserver2" {
  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.websg.id]
  subnet_id              = aws_subnet.subnet2.id
  user_data              = base64encode(file(var.userdata2))
}

resource "aws_lb" "myalb" {
  name               = var.alb_name
  internal           = var.alb_internal #internerAccess
  load_balancer_type = var.alb_type
  security_groups    = [aws_security_group.websg.id]
  subnets            = [aws_subnet.subnet1.id, aws_subnet.subnet2.id]
  tags = {
    Name = "WEB-ALB"
  }
}
#Targer-Group
resource "aws_lb_target_group" "mytg" {
  name     = var.tg_name
  port     = var.http_port
  protocol = var.http_protocol
  vpc_id   = aws_vpc.myvpc.id
  health_check {
    path = "/"
    port = "traffic-port"
  }
}
resource "aws_lb_target_group_attachment" "target-1" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.webserver1.id
  port             = var.http_port
}
resource "aws_lb_target_group_attachment" "target-2" {
  target_group_arn = aws_lb_target_group.mytg.arn
  target_id        = aws_instance.webserver2.id
  port             = var.http_port
}
resource "aws_lb_listener" "listener" {
  load_balancer_arn = aws_lb.myalb.arn
  port              = var.http_port
  protocol          = var.http_protocol

  default_action {
    target_group_arn = aws_lb_target_group.mytg.arn
    type             = "forward"
  }
}
