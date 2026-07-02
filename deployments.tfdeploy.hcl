# ============================================================================
# DEVELOPMENT DEPLOYMENT
# ============================================================================
deployment "development" {
  inputs = {
    # Environment & Region
    environment = "development"
    aws_region  = "eu-west-1"
    region      = "eu-west-1"  # Used by components

    # Resource Naming
    name = "tfe-dev"

    # Networking & DNS
    hosted_zone_name = "mohamed-abdelbaset.sbx.hashidemos.io"
    dns_record       = "aws-tfe-fdo-stacks.mohamed-abdelbaset.sbx.hashidemos.io"

    # ACME/Let's Encrypt Configuration
    # Use staging for testing to avoid rate limits
    acme_server_url = "https://acme-staging-v02.api.letsencrypt.org/directory"
    # For production, use:
    # acme_server_url = "https://acme-v02.api.letsencrypt.org/directory"
    
    # Email for ACME/Let's Encrypt
    email = "admin@example.com"

    # TFE Configuration
    tfe_hostname            = "tfe-dev.example.com"
    tfe_license             = file("/Users/mohamedayman/Downloads/terraform_stacks.hclic")  # Update path
    tfe_admin_password      = "Mystrongpassword123"  # Change this!
    tfe_encryption_password = "Mystrongpassword123"  # Change this!
    tfe_image_tag           = "2.0.3"     # Update to desired version
    
    # TFE Directories
    certs_dir = "/etc/terraform-enterprise/certs"
    data_dir  = "/etc/terraform-enterprise/"

    # EC2 Instance
    instance_type = "t2.large"

    # Database Configuration
    db_user      = "postgres"
    rds_password = "Mystrongpassword123"  # Change this!
    rds_db_name  = "tfe"

    # S3 Storage
    s3_bucket_name = "tfe-dev-data-bucket-unique-name"  # Must be globally unique
  }
}