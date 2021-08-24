  resource "aws_db_instance" "rds_quality_manager" {
  identifier          = "rds-quality-manager"
  allocated_storage    = 10
  engine               = var.db_produto
  engine_version       = "12.5"
  instance_class       = "db.t3.small"
  name                 = var.db_name
  username             = var.db_user
  password             = var.db_password
  availability_zone    = "us-east-1a"
  db_subnet_group_name = "default-vpc-0be8c96a29cbc5806"
  vpc_security_group_ids = [aws_security_group.sg_MD2_quality_manager.id]
  publicly_accessible   = true
 // parameter_group_name = "default.mysql5.7"
  skip_final_snapshot  = true

   tags = {
    Name = "Quality Manager"
  }

} 

 