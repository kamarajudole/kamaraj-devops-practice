variable "region" {
  description = "AWS region"
  type        = string
  default     = "ap-south-1"
}

variable "bucket_name" {
  description = "S3nimda (must be globally unique)"
  type        = string
  default     = "kamaraj-terraform-s3-<replace-with-unique-suffix>"
}
