variable "s3_bucket_name" {
  default = "kamaraj-terraform-s3-20251008"
}

provider "aws" {
  region = "us-east-1"
}

resource "aws_s3_bucket" "demo_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true

  tags = {
    Name        = var.s3_bucket_name
    Environment = "dev"
    Owner       = "kamaraj"
  }
}

resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.demo_bucket.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.demo_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

output "s3_bucket_name" {
  value = aws_s3_bucket.demo_bucket.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}
