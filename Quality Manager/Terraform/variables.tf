//Variaveis RDS
variable "db_produto" {
  type    = string
  default = "postgres"
}


variable "db_name" {
  type    = string
  default = "postgress_quality_manager"
}


variable "db_user" {
  type    = string
  default = "postgres"
}

variable "db_password" {
  type    = string
  default = "postgres1234567"
}

//variaveis ec2

variable "user_name_ec2" {
  type    = string
  default = "ec2-user"
}