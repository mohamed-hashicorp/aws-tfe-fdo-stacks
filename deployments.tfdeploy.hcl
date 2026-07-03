# ============================================================================
# SECRETS
# Pulls sensitive values from an HCP Terraform variable set at deploy time,
# so they never live in VCS. Variables must exist in the set as sensitive
# Terraform-category variables with matching keys (e.g. "tfe_license").
# ============================================================================
store "varset" "secrets" {
  id       = "varset-shzk7VwtSUorrQea" # <-- your variable set ID
  category = "terraform"
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
    dns_record       = "aws-tfe-fdo-stacks1.mohamed-abdelbaset.sbx.hashidemos.io"

    # ACME/Let's Encrypt Configuration
    # Use staging for testing to avoid rate limits
    # acme_server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
    acme_server_url = "https://acme-v02.api.letsencrypt.org/directory"

    
    # Email for ACME/Let's Encrypt
    email = "Mohamed.Ayman@ibm.com"

    # TFE Configuration
    # IMPORTANT: override tfe_license, tfe_admin_password, tfe_encryption_password,
    # and rds_password with sensitive values via the TFE stack Variables UI
    tfe_hostname            = "aws-tfe-fdo-stacks1.mohamed-abdelbaset.sbx.hashidemos.io"
    tfe_license             = store.varset.secrets.tfe_license
    tfe_admin_password      = "Mystrongpassword123"
    tfe_encryption_password = "Mystrongpassword123"
    tfe_image_tag           = "2.0.3"

    # TFE Directories
    certs_dir = "/etc/terraform-enterprise/certs"
    data_dir  = "/etc/terraform-enterprise/"

    # EC2 Instance
    instance_type = "t2.large"

    # Database Configuration
    db_user      = "postgres"
    rds_password = "Mystrongpassword123"
    rds_db_name  = "tfe"

    # S3 Storage
    s3_bucket_name = "tfe-dev-data-bucket-unique-name"
  }
}
