terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0" # adjust if needed
    }
  }
  required_version = ">= 1.0"
}

provider "aws" {
  region = var.region
}

resource "aws_s3_bucket" {
  bucket = var.bucket_name

  # Security defaults
  acl    = "private"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  tags = {
    Name        = var.bucket_name
    Environment = "dev"
    CreatedBy   = "terraform"
  }
}

resource "aws_s3_bucket_public_access_block" "this" {
  bucket = aws_s3_bucket.this.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}
