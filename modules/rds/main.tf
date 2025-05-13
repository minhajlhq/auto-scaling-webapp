resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = "${var.name_prefix}-rds-subnet-group"
  subnet_ids = var.private_subnet_ids

  tags = {
    Name = "${var.name_prefix}-rds-subnet-group"
  }
}
resource "aws_security_group" "rds_sg" {
  name        = "${var.name_prefix}-rds-sg"
  description = "Allow DB access from EC2 instances only"
  vpc_id      = var.vpc_id
  ingress {
    from_port       = var.db_port
    to_port         = var.db_port
    protocol        = "tcp"
    security_groups = [var.ec2_sg_id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
  resource "aws_db_parameter_group" "rds_params" {
  name   = "${var.name_prefix}-rds-params"
  family = var.db_family

   parameter {
    name  = "max_connections"
    value = "100"
  }

  }
  resource "aws_db_instance" "rds" {
  identifier              = "${var.name_prefix}-rds"
  engine                  = var.engine
  instance_class          = var.instance_class
  username                = var.username
  password                = var.password
   db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  parameter_group_name    = aws_db_parameter_group.rds_params.name
  allocated_storage       = var.allocated_storage

   skip_final_snapshot     = true
  publicly_accessible     = false
  multi_az                = var.multi_az
  port                    = var.db_port
   tags = {
    Name = "${var.name_prefix}-rds"
  }
}