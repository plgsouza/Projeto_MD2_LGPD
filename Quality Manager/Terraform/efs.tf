resource "aws_efs_file_system" "qmanager" {
  depends_on = [aws_instance.quality_manager, aws_security_group.sg_MD2_quality_manager,]
  creation_token = "qmanager"
  availability_zone_name = "us-east-1a"

  tags = {
    Name = "Quality Manager"
  }

}

resource "aws_efs_mount_target" "mount" {
  depends_on = [aws_efs_file_system.qmanager,]
  file_system_id = aws_efs_file_system.qmanager.id
  subnet_id      = "subnet-0a3c8d5a95265c9aa"
  security_groups = [aws_security_group.sg_MD2_quality_manager.id]
}

