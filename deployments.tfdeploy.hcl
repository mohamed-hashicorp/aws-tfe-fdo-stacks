# ============================================================================
# SENSITIVE VARIABLES — set these in TFE as sensitive stack variables
# ============================================================================
variable "tfe_license" {
  type      = string
  sensitive = true
}

variable "tfe_admin_password" {
  type      = string
  sensitive = true
}

variable "tfe_encryption_password" {
  type      = string
  sensitive = true
}

variable "rds_password" {
  type      = string
  sensitive = true
}

# ============================================================================
# DEVELOPMENT DEPLOYMENT
# ============================================================================
deployment "development" {
  inputs = {
    # Environment & Region
    environment = "development"
    aws_region  = "eu-west-1"
    region      = "eu-west-1"

    # Resource Naming
    name = "tfe-dev"

    # Networking & DNS
    hosted_zone_name = "mohamed-abdelbaset.sbx.hashidemos.io"
    dns_record       = "aws-tfe-fdo-stacks.mohamed-abdelbaset.sbx.hashidemos.io"

    # ACME/Let's Encrypt Configuration
    # Use staging for testing to avoid rate limits
    acme_server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"

    # Email for ACME/Let's Encrypt
    email = "admin@example.com"

    # TFE Configuration
    tfe_hostname            = "aws-tfe-fdo-stacks.mohamed-abdelbaset.sbx.hashidemos.io"
    tfe_license             = var.tfe_license
    tfe_admin_password      = var.tfe_admin_password
    tfe_encryption_password = var.tfe_encryption_password
    tfe_image_tag           = "2.0.3"

    # TFE Directories
    certs_dir = "/etc/terraform-enterprise/certs"
    data_dir  = "/etc/terraform-enterprise/"

    # EC2 Instance
    instance_type = "t2.large"

    # Database Configuration
    db_user      = "postgres"
    rds_password = var.rds_password
    rds_db_name  = "tfe"

    # S3 Storage
    s3_bucket_name = "tfe-dev-data-bucket-unique-name"
  }
}
