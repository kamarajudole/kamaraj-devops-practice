terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.3.0"
}

provider "aws" {
  region = var.region
}

# S3 Bucket (no ACLs)
resource "aws_s3_bucket" "this" {
  bucket        = var.s3_bucket_name
  force_destroy = true  # allows deletion even if not empty

  tags = {
    Name        = var.s3_bucket_name
    Environment = "dev"
    Owner       = "kamaraj"
  }
}

# Disable Public Access
resource "aws_s3_bucket_public_access_block" "block" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Ownership controls (disable ACLs)
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.this.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# Outputs
output "s3_bucket_name" {
  value = aws_s3_bucket.this.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.this.arn
}
