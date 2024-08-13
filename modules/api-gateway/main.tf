provider "aws" {
  region = var.region
}

resource "aws_api_gateway_rest_api" "ecommerce_api" {
  name        = "${var.environment}-ecommerce-api"
  description = "API Gateway for E-Commerce Flash Sale Platform"
}

# Deployment stage
resource "aws_api_gateway_stage" "api_stage" {
  stage_name    = var.environment
  rest_api_id   = aws_api_gateway_rest_api.ecommerce_api.id
  deployment_id = aws_api_gateway_deployment.api_deployment.id

  lifecycle {
    ignore_changes = all
  }
}


# Users Resource
resource "aws_api_gateway_resource" "users_resource" {
  rest_api_id = aws_api_gateway_rest_api.ecommerce_api.id
  parent_id   = aws_api_gateway_rest_api.ecommerce_api.root_resource_id
  path_part   = "users"
}

resource "aws_api_gateway_method" "users_post" {
  rest_api_id   = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id   = aws_api_gateway_resource.users_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "users_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id             = aws_api_gateway_resource.users_resource.id
  http_method             = aws_api_gateway_method.users_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.user_service_lambda_arn}/invocations"
}

# Orders Resource
resource "aws_api_gateway_resource" "orders_resource" {
  rest_api_id = aws_api_gateway_rest_api.ecommerce_api.id
  parent_id   = aws_api_gateway_rest_api.ecommerce_api.root_resource_id
  path_part   = "orders"
}

resource "aws_api_gateway_method" "orders_post" {
  rest_api_id   = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id   = aws_api_gateway_resource.orders_resource.id
  http_method   = "POST"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "orders_post_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id             = aws_api_gateway_resource.orders_resource.id
  http_method             = aws_api_gateway_method.orders_post.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.order_service_lambda_arn}/invocations"
}

# Inventory Resource
resource "aws_api_gateway_resource" "inventory_resource" {
  rest_api_id = aws_api_gateway_rest_api.ecommerce_api.id
  parent_id   = aws_api_gateway_rest_api.ecommerce_api.root_resource_id
  path_part   = "inventory"
}

resource "aws_api_gateway_method" "inventory_get" {
  rest_api_id   = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id   = aws_api_gateway_resource.inventory_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "inventory_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id             = aws_api_gateway_resource.inventory_resource.id
  http_method             = aws_api_gateway_method.inventory_get.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.inventory_service_lambda_arn}/invocations"
}

# Product Resource
resource "aws_api_gateway_resource" "product_resource" {
  rest_api_id = aws_api_gateway_rest_api.ecommerce_api.id
  parent_id   = aws_api_gateway_rest_api.ecommerce_api.root_resource_id
  path_part   = "products"
}

resource "aws_api_gateway_method" "product_get" {
  rest_api_id   = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id   = aws_api_gateway_resource.product_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "product_get_integration" {
  rest_api_id             = aws_api_gateway_rest_api.ecommerce_api.id
  resource_id             = aws_api_gateway_resource.product_resource.id
  http_method             = aws_api_gateway_method.product_get.http_method
  integration_http_method = "GET"
  type                    = "AWS_PROXY"
  uri                     = "arn:aws:apigateway:${var.region}:lambda:path/2015-03-31/functions/${var.product_service_lambda_arn}/invocations"
}

# Deploy the API
resource "aws_api_gateway_deployment" "api_deployment" {
  rest_api_id = aws_api_gateway_rest_api.ecommerce_api.id
  stage_name  = var.environment

  depends_on = [
    aws_api_gateway_integration.users_post_integration,
    aws_api_gateway_integration.orders_post_integration,
    aws_api_gateway_integration.inventory_get_integration,
    aws_api_gateway_integration.product_get_integration
  ]
}
