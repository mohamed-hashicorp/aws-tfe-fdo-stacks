variable "name" {
  description = "Name"
}

variable "hosted_zone_name" {
  description = "Route53 hosted zone name"
}

variable "dns_record" {
  description = "DNS record"
}

variable "email" {
  description = "Email for ACME/Let's Encrypt registration"
}

variable "region" {
  description = "AWS region"
}

variable "acme_server_url" {
  description = "ACME server URL"
  default     = "https://acme-v02.api.letsencrypt.org/directory"
}