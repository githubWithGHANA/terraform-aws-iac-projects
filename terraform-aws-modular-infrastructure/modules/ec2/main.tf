resource "aws_instance" "web" {
  count                  = var.instance_count
  ami                    = var.ami_id
  instance_type          = var.instance_type
  subnet_id              = element(var.subnet_ids, count.index)
  vpc_security_group_ids = var.security_group_ids
  key_name               = var.key_name

  associate_public_ip_address = true

  
  # 👇 USER DATA PER INSTANCE
  user_data = file(element(var.user_data_files, count.index))

  tags = merge(
    var.tags,
    {
      Name = "${var.name}-ec2-${count.index + 1}"
    }
  )
}
