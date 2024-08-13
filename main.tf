terraform {
  required_version = ">= 1.0.0"

  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 5.0"
    }
  }

  backend "s3" {
    bucket = "ecommerce-flash-sale-platform-terraform-state-bucket"
    key = "ecommerce-flash-sale-platform/terraform.tfstate"
    region = "us-east-1"
    encrypt = true
    dynamodb_table = "terraform-locks"
  }
}

provider "aws" {
  region = var.region
}

module "lambda" {
  source = "./modules/lambda"
  environment = var.environment
  s3_bucket_arn = module.s3.bucket_arn
  api_gateway_arn = module.api_gateway.api_gateway_arn
}


module "api_gateway" {
  source = "./modules/api-gateway"
  
  environment = var.environment
  user_service_lambda_arn = module.lambda.user_service_lambda_arn
  order_service_lambda_arn = module.lambda.order_service_lambda_arn
  inventory_service_lambda_arn = module.lambda.inventory_service_lambda_arn
  product_service_lambda_arn = module.lambda.product_service_lambda_arn
  order_processing_lambda_arn = module.lambda.order_processing_lambda_arn
}



module "rds" {
  source = "./modules/rds"
}

module "cognito" {
  source = "./modules/cognito"
}

module "msk" {
  source = "./modules/msk"
}

module "s3" {
  source = "./modules/s3"
  environment = var.environment
}
