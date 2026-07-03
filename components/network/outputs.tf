output "security_group_id" {
  description = "ID of the security group"
  value       = aws_security_group.web.id
}

output "db_subnet_group_name" {
  description = "Name of the RDS subnet group"
  value       = aws_db_subnet_group.default.name
}

output "route53_zone_id" {
  description = "Route53 hosted zone ID"
  value       = data.aws_route53_zone.server_zone.zone_id
}

output "acme_certificate_pem" {
  description = "ACME certificate PEM"
  value       = acme_certificate.server.certificate_pem
  sensitive   = true
}

output "acme_private_key_pem" {
  description = "ACME certificate private key PEM"
  value       = acme_certificate.server.private_key_pem
  sensitive   = true
}

output "acme_issuer_pem" {
  description = "ACME certificate issuer PEM"
  value       = acme_certificate.server.issuer_pem
  sensitive   = true
}