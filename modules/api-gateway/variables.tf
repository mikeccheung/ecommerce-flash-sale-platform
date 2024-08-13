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

variable "user_service_lambda_arn" {
  description = "ARN of the User Service Lambda function"
  type        = string
}

variable "order_service_lambda_arn" {
  description = "ARN of the Order Service Lambda function"
  type        = string
}

variable "inventory_service_lambda_arn" {
  description = "ARN of the Inventory Service Lambda function"
  type        = string
}

variable "product_service_lambda_arn" {
  description = "ARN of the Product Service Lambda function"
  type        = string
}

variable "order_processing_lambda_arn" {
  description = "ARN of the Order Processing Lambda function"
  type        = string
}
