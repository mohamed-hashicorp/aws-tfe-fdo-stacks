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
    # IMPORTANT: override tfe_license, tfe_admin_password, tfe_encryption_password,
    # and rds_password with sensitive values via the TFE stack Variables UI
    tfe_hostname            = "aws-tfe-fdo-stacks.mohamed-abdelbaset.sbx.hashidemos.io"
    tfe_license             = "REPLACE_WITH_LICENSE_CONTENT"
    tfe_admin_password      = "REPLACE_WITH_STRONG_PASSWORD"
    tfe_encryption_password = "REPLACE_WITH_STRONG_PASSWORD"
    tfe_image_tag           = "v202505-1"

    # TFE Directories
    certs_dir = "/etc/terraform-enterprise/certs"
    data_dir  = "/etc/terraform-enterprise/"

    # EC2 Instance
    instance_type = "t2.large"

    # Database Configuration
    db_user      = "postgres"
    rds_password = "REPLACE_WITH_STRONG_PASSWORD"
    rds_db_name  = "tfe"

    # S3 Storage
    s3_bucket_name = "tfe-dev-data-bucket-unique-name"
  }
}
