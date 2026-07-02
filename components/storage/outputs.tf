output "s3_bucket_id" {
  description = "S3 bucket ID"
  value       = aws_s3_bucket.tfe_data.id
}

output "s3_bucket_arn" {
  description = "S3 bucket ARN"
  value       = aws_s3_bucket.tfe_data.arn
}

output "s3_bucket_name" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.tfe_data.bucket
}

output "s3_bucket_region" {
  description = "S3 bucket region"
  value       = aws_s3_bucket.tfe_data.region
}

output "iam_policy_id" {
  description = "IAM policy ID for S3 access"
  value       = aws_iam_role_policy.s3_access.id
}