resource "aws_security_group" "sg_MD2_portal_titular" {
  name = "sg_MD2_portal_titular"
  description = "grupo para projeto MD2"
  vpc_id = "vpc-0be8c96a29cbc5806"

  
   ingress  {
      protocol  = "icmp" // liberação ping
      self      = true
      from_port = -1
      to_port   = -1
      cidr_blocks = ["0.0.0.0/0"]
    }
  
  ingress {
      protocol  = "tcp" // liberação conexão instância ssh
      self      = true
      from_port = 22
      to_port   = 22
      cidr_blocks = ["0.0.0.0/0"]
    }
  
  ingress  {
      protocol  = "tcp" // liberação teste apache
      self      = true
      from_port = 8080
      to_port   = 8080
      cidr_blocks = ["0.0.0.0/0"]
    }


  egress {
      from_port   = 0
      to_port     = 0
      protocol    = "-1"
      cidr_blocks = ["0.0.0.0/0"]
    }
  
}
