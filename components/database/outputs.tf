output "rds_endpoint" {
  description = "RDS instance endpoint (host:port)"
  value       = "${aws_db_instance.default.address}:${aws_db_instance.default.port}"
}

output "rds_address" {
  description = "RDS instance address (hostname only)"
  value       = aws_db_instance.default.address
}

output "rds_port" {
  description = "RDS instance port"
  value       = aws_db_instance.default.port
}

output "rds_db_name" {
  description = "RDS database name"
  value       = aws_db_instance.default.db_name
}

output "rds_identifier" {
  description = "RDS instance identifier"
  value       = aws_db_instance.default.identifier
}