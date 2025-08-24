resource "aws_s3_bucket" "example" {
  bucket = var.bucket_name
  acl    = var.acl

  versioning {
    enabled = var.versioning
  }

  tags = {
    Name        = var.bucket_name
    Environment = var.environment
  }
}