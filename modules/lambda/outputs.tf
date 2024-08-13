output "user_service_lambda_arn" {
  description = "ARN of the User Service Lambda"
  value       = aws_lambda_function.user_service.arn
}

output "order_service_lambda_arn" {
  description = "ARN of the Order Service Lambda"
  value       = aws_lambda_function.order_service.arn
}

output "inventory_service_lambda_arn" {
  description = "ARN of the Inventory Service Lambda"
  value       = aws_lambda_function.inventory_service.arn
}

output "product_service_lambda_arn" {
  description = "ARN of the Product Service Lambda"
  value       = aws_lambda_function.product_service.arn
}

output "order_processing_lambda_arn" {
  description = "ARN of the Order Processing Lambda"
  value       = aws_lambda_function.order_processing.arn
}
