output "dns_name" {
  value = aws_instance.portal_titular[0].public_dns
}

output "ip_instance" {
  value = aws_instance.portal_titular[0].public_ip
}


output "id_instance" {
  value = aws_instance.portal_titular[0].id
}

