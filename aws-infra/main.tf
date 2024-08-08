################## Modules Start ##################

module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = "assignment_vpc"
  cidr = "10.0.0.0/16"

  azs             = ["ap-south-1a", "ap-south-1b", "ap-south-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
  enable_vpn_gateway = false

  tags = {
    Terraform = "true"
    Environment = "dev"
  }
}

################## Modules End ##################

################## Resources Start ##################

resource "aws_security_group" "assignment_ec2_sg" {
  name_prefix = "assignment_ec2_sg"
  description = "Allow inbound traffic on ports 80, 443, and 22"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
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

  tags = {
    Name = "assignment_ec2_sg"
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_security_group" "assignment_rds_sg" {
  name_prefix = "assignment_rds_sg"
  description = "Allow inbound traffic on port 3306"

  vpc_id = module.vpc.vpc_id

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "assignment_rds_sg"
    Terraform = "true"
    Environment = "dev"
  }
}


resource "aws_db_subnet_group" "assignment_db_subnet_group" {
  name       = "assignment-db-subnet-group"
  subnet_ids = module.vpc.private_subnets

  tags = {
    Name = "assignment-db-subnet-group"
    Terraform = "true"
    Environment = "dev"
  }
}


resource "aws_instance" "assignment_ec2_linux_server" {
  ami           = "ami-0c2af51e265bd5e0e"
  instance_type = "t2.micro"
  subnet_id     = module.vpc.public_subnets[0]
  vpc_security_group_ids = [aws_security_group.assignment_ec2_sg.id]
  key_name      = "dev"
  associate_public_ip_address = true

  tags = {
    Name = "assignment_ec2_linux_server"
    Terraform = "true"
    Environment = "dev"
  }
}

resource "aws_db_instance" "assignment_rds_mysql_instance" {
  identifier = "assignment-rds-mysql-instance"
  allocated_storage    = 10
  db_name              = "assignmentdb"
  engine               = "mysql"
  engine_version       = "8.0"
  instance_class       = "db.t3.micro"
  username             = "admin"
  password             = "password"
  parameter_group_name = "default.mysql8.0"
  skip_final_snapshot  = true
  db_subnet_group_name = aws_db_subnet_group.assignment_db_subnet_group.name
  vpc_security_group_ids = [aws_security_group.assignment_rds_sg.id]

  tags = {
    Name = "assignment_rds_mysql_instance"
    Terraform = "true"
    Environment = "dev"
  }
}

################## Resources End ##################
