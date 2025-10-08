terraform {
  required_version = ">= 1.3.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

# -------------------------------
# S3 Bucket Creation
# -------------------------------
resource "aws_s3_bucket" "demo_bucket" {
  bucket        = var.s3_bucket_name
  force_destroy = true  # deletes bucket even if non-empty

  tags = {
    Name        = var.s3_bucket_name
    Environment = "Dev"
    Owner       = "Kamaraj"
  }
}

# -------------------------------
# Ownership Controls (disable ACLs)
# -------------------------------
resource "aws_s3_bucket_ownership_controls" "ownership" {
  bucket = aws_s3_bucket.demo_bucket.id

  rule {
    object_ownership = "BucketOwnerEnforced"
  }
}

# -------------------------------
# Block Public Access
# -------------------------------
resource "aws_s3_bucket_public_access_block" "block" {
  bucket                  = aws_s3_bucket.demo_bucket.id
  block_public_acls        = true
  ignore_public_acls       = true
  block_public_policy      = true
  restrict_public_buckets  = true
}

# -------------------------------
# Outputs
# -------------------------------
output "s3_bucket_name" {
  value = aws_s3_bucket.demo_bucket.bucket
}

output "s3_bucket_arn" {
  value = aws_s3_bucket.demo_bucket.arn
}
