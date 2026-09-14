terraform {
  required_version = ">= 1.6.0"

  backend "s3" {
    bucket         = "tf-state-joshuacloud-admin-backend"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "tf-state-locks"
    encrypt        = true
  }
}

provider "aws" {
  region = "us-east-1"
}
resource "aws_iam_role" "lambda_role" {
  name = "lab-lambda-role"

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
  role       = aws_iam_role.lambda_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

module "lambda" {
  source = "./modules/lambda"
  role_arn          = aws_iam_role.lambda_role.arn
  api_execution_arn = module.api_gateway.execution_arn



  function_name = "lab-lambda"
  handler       = "index.handler"
  runtime       = "python3.9"
  filename      = "envs/dev_staging_prod/lambda.zip"



  tags = {
    Environment = "dev"
    Project     = "lab-simulation"
  }
}
module "api_gateway" {
  source     = "./modules/api_gateway"

  api_name   = "lab-api"
  lambda_arn = module.lambda.lambda_invoke_arn
  route_key  = "GET /"
  stage_name = "$default"

  stage = {
    name = "dev"
  }
}


