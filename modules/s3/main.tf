data "aws_caller_identity" "current" {}

resource "aws_s3_bucket" "product_bucket" {
  bucket = "${data.aws_caller_identity.current.account_id}-ecommerce-product-bucket"

  tags = {
    Name        = "${data.aws_caller_identity.current.account_id}-ecommerce-product-bucket"
    Environment = var.environment
  }
}

resource "aws_s3_bucket_versioning" "product_bucket_versioning" {
  bucket = aws_s3_bucket.product_bucket.id

  versioning_configuration {
    status = "Enabled"
  }
}

output "bucket_name" {
  description = "The name of the S3 bucket"
  value       = aws_s3_bucket.product_bucket.id
}

output "bucket_arn" {
  description = "The ARN of the S3 bucket"
  value       = aws_s3_bucket.product_bucket.arn
}
