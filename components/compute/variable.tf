variable "name" {
  description = "Name of the TFE instance"    
}

variable "instance_type" {
  description = "EC2 Instance type"  
}

variable "email" {
  description = "Email for the admin user"
}

variable "tfe_license" {
  description = "TFE license file"
  sensitive   = true
}   

variable "tfe_hostname" { 
  description = "TFE hostname"
}

variable "tfe_admin_password" {
  description = "TFE admin password"
  sensitive   = true
}

variable "tfe_encryption_password" {
  description = "TFE encryption password"
  sensitive   = true
}

variable "tfe_image_tag" {
  description = "TFE image tag"
}

variable "certs_dir" {
  description = "Directory for storing certificates"
}

variable "data_dir" {
  description = "Directory for storing data"
}

variable "s3_bucket_name" {
  description = "S3 bucket name"
}

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

variable "region" {
  description = "AWS region"
}

variable "dns_record" {
  description = "TFE DNS record"  
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name"
}

variable "security_group_id" {
  description = "Security group ID from network component"
}

variable "rds_endpoint" {
  description = "RDS endpoint from database component"
}

variable "acme_certificate_pem" {
  description = "ACME certificate PEM from network component"
  sensitive   = true
}

variable "acme_private_key_pem" {
  description = "ACME private key PEM from network component"
  sensitive   = true
}

variable "acme_issuer_pem" {
  description = "ACME issuer PEM from network component"
  sensitive   = true
}

variable "route53_zone_id" {
  description = "Route53 zone ID from network component"
}