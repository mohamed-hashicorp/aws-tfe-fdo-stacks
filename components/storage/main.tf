# --- S3 Bucket ---
moved {
  from = aws_s3_bucket.example
  to   = aws_s3_bucket.tfe_data
}

resource "aws_s3_bucket" "tfe_data" {
  bucket = var.s3_bucket_name

  tags = {
    Name = var.s3_bucket_name
  }
}

# --- IAM Role Policy for S3 Access ---
moved {
  from = aws_iam_role_policy.s3-access-policy
  to   = aws_iam_role_policy.s3_access
}

resource "aws_iam_role_policy" "s3_access" {
  name = "${var.s3_bucket_name}-policy"
  role = var.iam_role_name

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid    = "BucketAccess",
        Effect = "Allow",
        Action = [
          "s3:PutObject",
          "s3:GetObject",
          "s3:ListBucket",
          "s3:DeleteObject",
          "s3:GetBucketLocation"
        ],
        Resource = [
          aws_s3_bucket.tfe_data.arn,
          "${aws_s3_bucket.tfe_data.arn}/*",
        ]
      }
    ]
  })
}
