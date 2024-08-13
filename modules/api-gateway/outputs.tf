output "api_url" {
  description = "The base URL of the API Gateway"
  value       = "${aws_api_gateway_rest_api.ecommerce_api.execution_arn}*/*"
}

output "api_gateway_arn" {
  value = aws_api_gateway_rest_api.ecommerce_api.execution_arn
}
