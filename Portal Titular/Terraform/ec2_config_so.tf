 resource "null_resource" "ec2_config"{
  depends_on = [aws_instance.portal_titular,]
  connection{
      type = "ssh"
      user = "${var.user_name_ec2}"
      private_key = tls_private_key.ec2_key.private_key_pem 
      host = aws_instance.portal_titular[0].public_ip 
  }
  provisioner "remote-exec"{
      inline = [
          //Instalação dependencias
          "sudo yum install -y vim",
          "sudo yum -y install nfs-utils",
          "sudo service nfs-server start",
          "sudo yum install -y wget",
        
          //Instalação SSM 
          "sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm",
          "sudo systemctl enable amazon-ssm-agent",
          "sudo systemctl start amazon-ssm-agent",
          "sudo systemctl enable amazon-ssm-agent"
      ]
  }  
} 
 

//execução playboook ansible

resource "null_resource" "ansible_deploy"{
   depends_on = [null_resource.ec2_config,]
   connection{
      type = "ssh"
      user = "${var.user_name_ec2}"
      private_key = tls_private_key.ec2_key.private_key_pem 
      host = aws_instance.portal_titular[0].public_ip 
   }

provisioner "local-exec" {
    command = "sudo ansible-playbook  -i inventory.yaml tomcat.yml "
    }

}





 
