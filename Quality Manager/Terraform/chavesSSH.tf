//gerando chaves de acesso rsa
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
}
// gerando chave de acesso Key pair
resource "aws_key_pair" "MD2_LGPD_HML"{
    depends_on = [tls_private_key.ec2_key,]
    key_name = "Projeto_MD2_LGPD_quality_manager_HML"
    public_key = tls_private_key.ec2_key.public_key_openssh
   
} 

//Salvando chave no diretorio  local 

resource "local_file" "ec2_key"{
    depends_on = [aws_key_pair.MD2_LGPD_HML,]
    content  = tls_private_key.ec2_key.private_key_pem
    filename = "Projeto_MD2_LGPD_HML"
    file_permission   = "0600"
    }

// gerando arquivo invetory.yaml  utilizando como template o arquivo  "inventory.tmpl, o arquivo inventory.yaml sera utilizado pelo ansible pois o mesmo contem os ips e keypars das maquinas criadas pelo pelo terraform"
resource "local_file" "ansible_inventory" {
  depends_on = [local_file.ec2_key,]
  content = templatefile("inventory.tmpl", {
      ip          = aws_instance.quality_manager[0].public_ip,
      ssh_keyfile = local_file.ec2_key.filename
  })
  filename = format("%s/%s", abspath(path.root), "inventory.yaml")
}