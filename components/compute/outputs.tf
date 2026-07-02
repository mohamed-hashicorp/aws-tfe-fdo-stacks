output "instance_id" {
  description = "EC2 instance ID"
  value       = aws_instance.this.id
}

output "instance_public_ip" {
  description = "EC2 instance public IP address"
  value       = aws_instance.this.public_ip
}

output "instance_private_ip" {
  description = "EC2 instance private IP address"
  value       = aws_instance.this.private_ip
}

output "instance_public_dns" {
  description = "EC2 instance public DNS name"
  value       = aws_instance.this.public_dns
}

output "iam_role_name" {
  description = "IAM role name for SSM"
  value       = aws_iam_role.ssm.name
}

output "iam_role_arn" {
  description = "IAM role ARN for SSM"
  value       = aws_iam_role.ssm.arn
}

output "instance_profile_name" {
  description = "IAM instance profile name"
  value       = aws_iam_instance_profile.ssm.name
}