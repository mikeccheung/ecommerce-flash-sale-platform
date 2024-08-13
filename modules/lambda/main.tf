resource "aws_lambda_function" "user_service" {
  function_name = "user_service_lambda-${var.environment}"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "scripts/user_service_lambda.handler"
  runtime       = "python3.8"
  
  filename      = "${path.module}/scripts/user_service_lambda.py"
  
  source_code_hash = filebase64sha256("${path.module}/scripts/user_service_lambda.py")
  
  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

resource "aws_lambda_function" "order_service" {
  function_name = "order_service_lambda-${var.environment}"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "scripts/order_service_lambda.handler"
  runtime       = "python3.8"
  
  filename      = "${path.module}/scripts/order_service_lambda.py"
  
  source_code_hash = filebase64sha256("${path.module}/scripts/order_service_lambda.py")
  
  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

resource "aws_lambda_function" "inventory_service" {
  function_name = "inventory_service_lambda-${var.environment}"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "scripts/inventory_service_lambda.handler"
  runtime       = "python3.8"
  
  filename      = "${path.module}/scripts/inventory_service_lambda.py"
  
  source_code_hash = filebase64sha256("${path.module}/scripts/inventory_service_lambda.py")
  
  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

resource "aws_lambda_function" "product_service" {
  function_name = "product_service_lambda-${var.environment}"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "scripts/product_service_lambda.handler"
  runtime       = "python3.8"
  
  filename      = "${path.module}/scripts/product_service_lambda.py"
  
  source_code_hash = filebase64sha256("${path.module}/scripts/product_service_lambda.py")
  
  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

resource "aws_lambda_function" "order_processing" {
  function_name = "order_processing_lambda-${var.environment}"
  role          = aws_iam_role.lambda_exec_role.arn
  handler       = "scripts/order_processing_lambda.handler"
  runtime       = "python3.8"
  
  filename      = "${path.module}/scripts/order_processing_lambda.py"
  
  source_code_hash = filebase64sha256("${path.module}/scripts/order_processing_lambda.py")
  
  environment {
    variables = {
      ENVIRONMENT = var.environment
    }
  }
}

data "aws_caller_identity" "current" {}

resource "aws_iam_role" "lambda_exec_role" {
  name = "lambda_exec_role-${var.environment}"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_basic_execution" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

resource "aws_iam_policy" "lambda_custom_policy" {
  name        = "lambda_custom_policy_${var.environment}"
  description = "Custom policy for Lambda to interact with required AWS services"
  
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "dynamodb:GetItem",
          "dynamodb:PutItem",
          "dynamodb:UpdateItem",
          "dynamodb:Scan",
          "dynamodb:Query"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:dynamodb:${var.region}:${data.aws_caller_identity.current.account_id}:table/*"
      },
      {
        Action = [
          "rds:DescribeDBInstances",
          "rds-db:connect"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
      {
        Action = [
          "secretsmanager:GetSecretValue"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:secretsmanager:${var.region}:${data.aws_caller_identity.current.account_id}:secret:*"
      },
      {
        Action = [
          "kafka:DescribeCluster",
          "kafka:DescribeTopic",
          "kafka:CreateTopic",
          "kafka:WriteData",
          "kafka:ReadData"
        ]
        Effect   = "Allow"
        Resource = "arn:aws:kafka:${var.region}:${data.aws_caller_identity.current.account_id}:cluster/*/*"
      },
      {
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:ListBucket"
        ]
        Effect   = "Allow"
        Resource = "${var.s3_bucket_arn}/*"
      },
      {
        Action = [
          "cognito-idp:AdminCreateUser",
          "cognito-idp:AdminInitiateAuth",
          "cognito-idp:AdminGetUser",
          "cognito-idp:AdminSetUserPassword"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lambda_custom_policy_attachment" {
  role       = aws_iam_role.lambda_exec_role.name
  policy_arn = aws_iam_policy.lambda_custom_policy.arn
}
