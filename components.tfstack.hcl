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
    name                 = var.name
    rds_password         = var.rds_password
    db_user              = var.db_user
    rds_db_name          = var.rds_db_name
    security_group_id    = component.network.security_group_id
    db_subnet_group_name = component.network.db_subnet_group_name
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
