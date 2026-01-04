output "vpc_id" { value = module.vpc.vpc_id }
output "public_subnet_ids" { value = module.vpc.public_subnet_ids }
output "private_subnet_id" { value = module.vpc.private_subnet_id }
output "ec2_instance_ids" { value = module.ec2.instance_ids }
output "ec2_public_ips" { value = module.ec2.public_ips }
output "alb_dns_name" { value = module.alb.alb_dns_name }
output "s3_bucket_name" { value = module.s3.bucket_name }
