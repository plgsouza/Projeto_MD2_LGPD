data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }

  owners = ["099720109477"] # Ubuntu
}

resource "aws_instance" "quality_manager" {
  depends_on = [aws_security_group.sg_MD2_quality_manager,]
  ami           = "ami-0b0af3577fe5e3532"
  instance_type = "t3.large"
  count = "1"
  key_name = aws_key_pair.MD2_LGPD_HML.key_name
  security_groups  = [aws_security_group.sg_MD2_quality_manager.id]
  subnet_id = "subnet-0a3c8d5a95265c9aa"
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name

 ebs_block_device {
    device_name           = "/dev/sdh"
    volume_type           = "gp2"
    volume_size           = "50"
    delete_on_termination = true
  }

  tags = {
    Name = "MD2_Quality_Manager_HML"
  }
}
