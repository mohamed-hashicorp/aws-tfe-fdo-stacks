required_providers {
  aws = {
    source  = "hashicorp/aws"
    version = "~> 5.0"
  }

  random = {
    source  = "hashicorp/random"
    version = "~> 3.6"
  }

  acme = {
    source  = "vancluever/acme"
    version = "~> 2.0"
  }

  tls = {
    source  = "hashicorp/tls"
    version = "~> 4.0"
  }
}

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

provider "tls" "main" {}

provider "acme" "main" {
  config {
    server_url = var.acme_server_url
  }
}
