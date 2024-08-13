# Comment these out if the modules aren't ready
# output "api_gateway_url" {
#   description = "The base URL of the API Gateway"
#   value       = module.api_gateway.api_url
# }

output "user_service_lambda_arn" {
  description = "ARN of the User Service Lambda function"
  value       = module.lambda.user_service_lambda_arn
}

output "order_service_lambda_arn" {
  description = "ARN of the Order Service Lambda function"
  value       = module.lambda.order_service_lambda_arn
}

output "inventory_service_lambda_arn" {
  description = "ARN of the Inventory Service Lambda function"
  value       = module.lambda.inventory_service_lambda_arn
}

output "product_service_lambda_arn" {
  description = "ARN of the Product Service Lambda function"
  value       = module.lambda.product_service_lambda_arn
}

output "order_processing_lambda_arn" {
  description = "ARN of the Order Processing Lambda function"
  value       = module.lambda.order_processing_lambda_arn
}

# output "rds_endpoint" {
#   description = "The endpoint of the RDS instance"
#   value       = module.rds.db_instance_endpoint
# }

# output "cognito_user_pool_id" {
#   description = "The ID of the Cognito User Pool"
#   value       = module.cognito.user_pool_id
# }

# output "msk_bootstrap_brokers" {
#   description = "The bootstrap brokers of the MSK cluster"
#   value       = module.msk.bootstrap_brokers
# }

output "s3_bucket_name" {
  description = "The name of the S3 bucket for static assets"
  value       = module.s3.bucket_name
}
