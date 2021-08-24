 output "dns_name_instance_ec2" {
  value = aws_instance.quality_manager[0].public_dns
}

output "ip_instance_ec2" {
  value = aws_instance.quality_manager[0].public_ip
}


output "id_instance_ec2" {
  value = aws_instance.quality_manager[0].id
} 

output "ip_instance_rds" {
  value = aws_db_instance.rds_quality_manager.address
} 

output "endpoint_instance_rds" {
  value = aws_db_instance.rds_quality_manager.endpoint
} 

output "id_instance_rds" {
  value = aws_db_instance.rds_quality_manager.id
}  