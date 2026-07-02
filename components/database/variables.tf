variable "rds_password" {
  description = "RDS password"
  sensitive   = true
}

variable "db_user" {
  description = "DB user"
}

variable "rds_db_name" {
  description = "RDS database name"
}

variable "name" {
  description = "Name of the TFE instance"    
}

variable "security_group_id" {
  description = "Security group ID from network component"
}

variable "db_subnet_group_name" {
  description = "DB subnet group name from network component"
}