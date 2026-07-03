## EC2 Instance Component

# --- Data Sources ---
data "aws_ami" "ubuntu_noble" {
  most_recent = true

  owners = ["099720109477"] # Canonical

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd-gp3/ubuntu-noble-24.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
}

# --- Route53 Hosted Zone ---
data "aws_route53_zone" "server_zone" {
  name         = var.hosted_zone_name
  private_zone = false
}

locals {
  resource_name = var.name
  subnet_id     = data.aws_subnets.default.ids[0]

  common_tags = {
    Name = local.resource_name
  }
}

# --- IAM Role for SSM ---
resource "aws_iam_role" "ssm" {
  name = "${local.resource_name}-ssm-role"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [{
      Effect    = "Allow",
      Principal = { Service = "ec2.amazonaws.com" },
      Action    = "sts:AssumeRole"
    }]
  })
}

resource "aws_iam_role_policy_attachment" "ssm_core" {
  role       = aws_iam_role.ssm.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "ssm" {
  name = "${local.resource_name}-instance-profile"
  role = aws_iam_role.ssm.name
}

# --- EC2 Instance ---
resource "aws_instance" "this" {
  ami                         = data.aws_ami.ubuntu_noble.id
  instance_type               = var.instance_type
  subnet_id                   = local.subnet_id
  vpc_security_group_ids      = [var.security_group_id]
  associate_public_ip_address = true
  iam_instance_profile        = aws_iam_instance_profile.ssm.name
  key_name                    = null

  root_block_device {
    volume_size = 100
    volume_type = "gp3"
    encrypted   = true
  }

  user_data_base64 = base64gzip(templatefile("${path.module}/cloud-init.tftpl", {
    server_cert             = indent(6, var.acme_certificate_pem)
    private_key             = indent(6, var.acme_private_key_pem)
    bundle_certs            = indent(6, var.acme_issuer_pem)
    email                   = var.email
    tfe_license             = var.tfe_license
    tfe_hostname            = var.dns_record
    tfe_admin_password      = var.tfe_admin_password
    tfe_encryption_password = var.tfe_encryption_password
    tfe_image_tag           = var.tfe_image_tag
    certs_dir               = var.certs_dir
    data_dir                = var.data_dir
    s3_bucket_name          = var.s3_bucket_name
    rds_password            = var.rds_password
    db_user                 = var.db_user
    db_endpoint             = var.rds_endpoint
    rds_db_name             = var.rds_db_name
    region                  = var.region
  }))

  tags = local.common_tags
}

# --- Route53 A Record pointing to EC2 public IP ---
resource "aws_route53_record" "server" {
  zone_id = var.route53_zone_id
  name    = var.dns_record
  type    = "A"
  ttl     = 60

  records = [aws_instance.this.public_ip]
}
