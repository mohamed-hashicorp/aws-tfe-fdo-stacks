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
