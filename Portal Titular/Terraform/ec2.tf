resource "aws_instance" "portal_titular" {
  depends_on = [aws_security_group.sg_MD2_portal_titular,]
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t3.small"
  count = "1"
  key_name = aws_key_pair.MD2_LGPD_HML.key_name
  vpc_security_group_ids  = ["sg-07de2e9f08052c13e"]
  security_groups  = [aws_security_group.sg_MD2_portal_titular.id]
  subnet_id = "subnet-0a3c8d5a95265c9aa"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

 root_block_device {
    volume_type           = "gp2"
    volume_size           = "30"
    delete_on_termination = true
  }

  tags = {
    Name = "MD2_Portal_Titular_HML"
  }
}

