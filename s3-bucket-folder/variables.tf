variable "region" {
  description = "AWS region for the S3 bucket"
  default     = "us-east-1"
}

variable "s3_bucket_name" {
  description = "Globally unique name for S3 bucket"
  default     = "kamaraj-terraform-s3-20251008-01"
}
