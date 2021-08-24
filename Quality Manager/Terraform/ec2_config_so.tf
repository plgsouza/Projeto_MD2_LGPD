 resource "null_resource" "ec2_config"{
  depends_on = [aws_efs_mount_target.mount,aws_instance.quality_manager,]
  connection{
      type = "ssh"
      user = "${var.user_name_ec2}"
      private_key = tls_private_key.ec2_key.private_key_pem 
      host = aws_instance.quality_manager[0].public_ip 
  }
  provisioner "remote-exec"{
      inline = [
          //Instalação dependencias
          "sudo yum install -y vim",
          "sudo yum -y install nfs-utils",
          "sudo service nfs-server start",
          "sudo yum install -y wget",
           
          // Montando efs
          "sudo mkdir /mnt/qmanager", 
          "sudo mount -t nfs4  -o nfsvers=4.1,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport ${aws_efs_mount_target.mount.ip_address}:/ /mnt/qmanager",
          "cd /mnt/qmanager",
          "sudo wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.99/bin/apache-tomcat-7.0.99.tar.gz",
          //Configuração Fstab 
          "sudo chown ec2-user:root /etc/fstab",
          "sudo echo '${aws_efs_mount_target.mount.ip_address}:/ /mnt/qmanager nfs4 nfsvers=4.0,rsize=1048576,wsize=1048576,hard,timeo=600,retrans=2,noresvport,mountport=2049 0 0' >> /etc/fstab",
          
          //Instalação SSM 
          "sudo dnf install -y https://s3.amazonaws.com/ec2-downloads-windows/SSMAgent/latest/linux_amd64/amazon-ssm-agent.rpm",
          "sudo systemctl enable amazon-ssm-agent",
          "sudo systemctl start amazon-ssm-agent",
          "sudo systemctl enable amazon-ssm-agent"
      ]
  }  
} 
 

// Sleep para execução plauybook ansible

/* resource "time_sleep" "wait_90_seconds" {
  depends_on = [null_resource.ec2_config,]

  create_duration = "90s"
}
 */
//execução playboook ansible

resource "null_resource" "ansible_deploy"{
   depends_on = [null_resource.ec2_config,]
   connection{
      type = "ssh"
      user = "${var.user_name_ec2}"
      private_key = tls_private_key.ec2_key.private_key_pem 
      host = aws_instance.quality_manager[0].public_ip 
   }

provisioner "local-exec" {
    command = "sudo ansible-playbook  -i inventory.yaml tomcat.yml "
    }

}





 
