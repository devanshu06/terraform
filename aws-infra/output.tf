output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_ids" {
  description = "The IDs of the public subnets"
  value       = module.vpc.public_subnets
}

output "private_subnet_ids" {
  description = "The IDs of the private subnets"
  value       = module.vpc.private_subnets
}

output "ec2_security_group_id" {
  description = "The ID of the security group for the EC2 instance"
  value       = aws_security_group.assignment_ec2_sg.id
}

output "rds_security_group_id" {
  description = "The ID of the security group for the RDS instance"
  value       = aws_security_group.assignment_rds_sg.id
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.assignment_ec2_linux_server.id
}

output "ec2_public_ip" {
  description = "The Public IP of the EC2 instance"
  value       = aws_instance.assignment_ec2_linux_server.public_ip
}

output "ec2_private_ip" {
  description = "The private IP of the EC2 instance"
  value       = aws_instance.assignment_ec2_linux_server.private_ip
}

output "rds_instance_endpoint" {
  description = "The endpoint of the RDS instance"
  value       = aws_db_instance.assignment_rds_mysql_instance.endpoint
}

output "rds_instance_identifier" {
  description = "The identifier of the RDS instance"
  value       = aws_db_instance.assignment_rds_mysql_instance.identifier
}

output "rds_instance_db_name" {
  description = "The name of the RDS database"
  value       = aws_db_instance.assignment_rds_mysql_instance.db_name
}

output "rds_instance_username" {
  description = "The username for the RDS database"
  value       = aws_db_instance.assignment_rds_mysql_instance.username
}
