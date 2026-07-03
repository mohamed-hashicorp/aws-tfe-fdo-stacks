variable "aws_region" {
  type        = string
  description = "AWS Region"
}

variable "environment" {
  type        = string
  description = "Environment name"
}

variable "name" {
  type        = string
  description = "Name for resources"
}

variable "hosted_zone_name" {
  type        = string
  description = "Route53 hosted zone name"
}

variable "email" {
  type        = string
  description = "Email address"
}

variable "tfe_license" {
  type        = string
  description = "TFE license"
  sensitive   = true
  ephemeral   = true
}

variable "tfe_hostname" {
  type        = string
  description = "TFE hostname"
}

variable "tfe_admin_password" {
  type        = string
  description = "TFE admin password"
  sensitive   = true
}

variable "tfe_encryption_password" {
  type        = string
  description = "TFE encryption password"
  sensitive   = true
}

variable "tfe_image_tag" {
  type        = string
  description = "TFE image tag"
}

variable "certs_dir" {
  type        = string
  description = "Certificates directory"
}

variable "data_dir" {
  type        = string
  description = "Data directory"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3 bucket name"
}

variable "rds_password" {
  type        = string
  description = "RDS password"
  sensitive   = true
}

variable "db_user" {
  type        = string
  description = "Database user"
}

variable "rds_db_name" {
  type        = string
  description = "RDS database name"
}

variable "region" {
  type        = string
  description = "AWS region"
}

variable "dns_record" {
  type        = string
  description = "DNS record"
}

variable "instance_type" {
  type        = string
  description = "EC2 instance type"
}

variable "acme_server_url" {
  type        = string
  description = "ACME server URL"
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}
