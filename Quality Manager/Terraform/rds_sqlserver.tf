resource "aws_db_instance" "rds_quality_manager_sql" {
  identifier             = "rds-quality-manager-sql"
  allocated_storage      = 20
  engine                 = var.db_produto_sql
  engine_version         = "13.00.5882.1.v1"
  instance_class         = "db.m5.xlarge"
  username               = var.db_user_sql
  password               = var.db_password_sql
  port                   = 1433
  availability_zone      = "us-east-1a"
  db_subnet_group_name   = "default-vpc-0be8c96a29cbc5806"
  vpc_security_group_ids = [aws_security_group.sg_MD2_quality_manager.id]
  license_model          = "license-included"
  publicly_accessible    = true
  skip_final_snapshot    = true

  tags = {
    Name = "Quality Manager"
  }

}

