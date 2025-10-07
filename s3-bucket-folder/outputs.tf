output "bucket_id" {
  description = "S3 bucket name"
  value       = aws_s3_bucket.this.id
}
