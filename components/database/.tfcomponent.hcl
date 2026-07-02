# --- RDS Instance ---
resource "aws_db_instance" "default" {
  allocated_storage = 10
  engine            = "postgres"
  engine_version    = "14.18"
  instance_class    = "db.t3.large"

  username = var.db_user
  password = var.rds_password
  db_name  = var.rds_db_name

  parameter_group_name = "default.postgres14"
  skip_final_snapshot  = true
  publicly_accessible  = false

  vpc_security_group_ids = [var.security_group_id]
  db_subnet_group_name   = var.db_subnet_group_name

  identifier                  = "${local.resource_name}-rds"
  allow_major_version_upgrade = true

  tags = {
    Name = "${local.resource_name}-rds"
  }
}

locals {
  resource_name = var.name

  common_tags = {
    Name = local.resource_name
  }
}
