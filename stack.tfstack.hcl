# Required providers
required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }

  random = {
    source  = "hashicorp/random"
    version = "~> 3.6"
  }
}

# Variables

variable "aws_region" {
  type = string
  description = "AWS Region"
}

variable "environment" {
  type = string
  description = "Environment name"
}

variable "name" {
  type = string
  description = "Name for resources"
}

variable "hosted_zone_name" {
  type = string
  description = "Route53 hosted zone name"
}

variable "email" {
  type = string
  description = "Email address"
}

variable "tfe_license" {
  type = string
  description = "TFE license"
  sensitive = true
}

variable "tfe_hostname" {
  type = string
  description = "TFE hostname"
}

variable "tfe_admin_password" {
  type = string
  description = "TFE admin password"
  sensitive = true
}

variable "tfe_encryption_password" {
  type = string
  description = "TFE encryption password"
  sensitive = true
}

variable "tfe_image_tag" {
  type = string
  description = "TFE image tag"
}

variable "certs_dir" {
  type = string
  description = "Certificates directory"
}

variable "data_dir" {
  type = string
  description = "Data directory"
}

variable "s3_bucket_name" {
  type = string
  description = "S3 bucket name"
}

variable "rds_password" {
  type = string
  description = "RDS password"
  sensitive = true
}

variable "db_user" {
  type = string
  description = "Database user"
}

variable "rds_db_name" {
  type = string
  description = "RDS database name"
}

variable "region" {
  type = string
  description = "AWS region"
}

variable "dns_record" {
  type = string
  description = "DNS record"
}

variable "instance_type" {
  type = string
  description = "EC2 instance type"
}

variable "acme_server_url" {
  type        = string
  description = "ACME server URL (use staging for testing, production for real certificates)"
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}

# AWS Provider configuration
provider "aws" "main" {
  config {
    region = var.aws_region

    default_tags {
      tags = {
        Project     = "TFE-FDO"
        ManagedBy   = "Terraform-Stacks"
        Environment = var.environment
      }
    }
  }
}

provider "random" "main" {}


# Components are deployed in dependency order: network -> database -> compute -> storage

component "network" {
  source = "./components/network"
  providers = {
    aws = provider.aws.main
  }
  inputs = {
    name             = var.name
    hosted_zone_name = var.hosted_zone_name
    email            = var.email
    region           = var.region
    dns_record       = var.dns_record
    acme_server_url  = var.acme_server_url
  }
}

component "database" {
  source = "./components/database"
  providers = {
    aws = provider.aws.main
  }
  inputs = {
    name                   = var.name
    rds_password           = var.rds_password
    db_user                = var.db_user
    rds_db_name            = var.rds_db_name
    security_group_id      = component.network.security_group_id
    db_subnet_group_name   = component.network.db_subnet_group_name
  }
}

component "compute" {
  source = "./components/compute"
  providers = {
    aws = provider.aws.main
  }
  inputs = {
    name                    = var.name
    instance_type           = var.instance_type
    hosted_zone_name        = var.hosted_zone_name
    email                   = var.email
    tfe_license             = var.tfe_license
    tfe_hostname            = var.tfe_hostname
    tfe_admin_password      = var.tfe_admin_password
    tfe_encryption_password = var.tfe_encryption_password
    tfe_image_tag           = var.tfe_image_tag
    certs_dir               = var.certs_dir
    data_dir                = var.data_dir
    s3_bucket_name          = var.s3_bucket_name
    rds_password            = var.rds_password
    db_user                 = var.db_user
    rds_db_name             = var.rds_db_name
    region                  = var.region
    dns_record              = var.dns_record
    security_group_id       = component.network.security_group_id
    rds_endpoint            = component.database.rds_endpoint
    acme_certificate_pem    = component.network.acme_certificate_pem
    acme_private_key_pem    = component.network.acme_private_key_pem
    acme_issuer_pem         = component.network.acme_issuer_pem
    route53_zone_id         = component.network.route53_zone_id
  }
}

component "storage" {
  source = "./components/storage"
  providers = {
    aws = provider.aws.main
  }
  inputs = {
    s3_bucket_name = var.s3_bucket_name
    iam_role_name  = component.compute.iam_role_name
  }
}