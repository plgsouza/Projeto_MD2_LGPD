//Variaveis RDS Postgress
variable "db_produto_postgres" {
  type    = string
  default = "postgres"
}


variable "db_name_postgres" {
  type    = string
  default = "postgress_quality_manager"
}


variable "db_user_postgres" {
  type    = string
  default = "postgres"
}

variable "db_password_postgres" {
  type    = string
  default = "postgres1234567"
}

//variaveis EC2

variable "user_name_ec2" {
  type    = string
  default = "ec2-user"
}


//Variaveis RDS SQLServer
variable "db_produto_sql" {
  type    = string
  default = "sqlserver-ee"
}


variable "db_user_sql" {
  type    = string
  default = "admin"
}

variable "db_password_sql" {
  type    = string
  default = "sql1234567"
}
