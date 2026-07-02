# --- Data Sources ---
data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# --- Security Group (HTTPS Only) ---
resource "aws_security_group" "web" {
  name        = "${local.resource_name}-sg"
  description = "Allow HTTPS and PostgreSQL only"
  vpc_id      = data.aws_vpc.default.id

  ingress {
    description = "HTTPS"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "PostgreSQL"
    from_port   = 5432
    to_port     = 5432
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTPS"
    from_port   = 8443
    to_port     = 8443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# --- RDS Subnet ---
resource "aws_db_subnet_group" "default" {
  name       = "${local.resource_name}-db-subnet-group"
  subnet_ids = data.aws_subnets.default.ids

  tags = {
    Name = "${local.resource_name}-db-subnet-group"
  }
}

# --- Route53 Hosted Zone ---
data "aws_route53_zone" "server_zone" {
  name         = var.hosted_zone_name
  private_zone = false
}

locals {
  resource_name = var.name

  common_tags = {
    Name = local.resource_name
  }
}

# ACME account private key (used to register with Let's Encrypt)
resource "tls_private_key" "acme_account" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# ACME registration (your Let's Encrypt account)
resource "acme_registration" "this" {
  account_key_pem = tls_private_key.acme_account.private_key_pem
  email_address   = var.email
}

# ACME certificate for your FQDN
resource "acme_certificate" "server" {
  account_key_pem = acme_registration.this.account_key_pem
  common_name     = var.dns_record

  # Default is 30 days – cert will only be renewed when it's close to expiring,
  # not on every apply. :contentReference[oaicite:1]{index=1}
  min_days_remaining = 30

  dns_challenge {
    provider = "route53"
    config = {
      AWS_HOSTED_ZONE_ID = data.aws_route53_zone.server_zone.zone_id
      AWS_REGION         = var.region
    }
  }
}

