variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name (e.g., dev, prod)"
  type        = string
  default     = "dev"
}

variable "s3_bucket_arn" {
  description = "The ARN of the S3 bucket"
  type        = string
}

variable "api_gateway_arn" {
  description = "The ARN of the API Gateway"
  type        = string
}
