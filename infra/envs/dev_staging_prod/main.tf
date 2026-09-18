terraform {
  backend "s3" {
    bucket         = "tf-state-joshuacloud-admin-backend"
    key            = "global/terraform.tfstate"
    region         = "us-east-1"
    use_lockfile = true
    encrypt        = true
  }
}

provider "aws"  {  
  region = "us-east-1"
}


module "dynamodb" {
  source = "../../modules/dynamodb"

  table_name = "lab-table"
  hash_key   = "id"

  tags = {
    Environment = "dev"
    Project     = "lab-simulation"
  }
}

module "s3_bucket" {
  source = "../../modules/s3"

  bucket_name        = "lab-s3-bucket-joshua"
  versioning_enabled = true

  tags = {
    Environment = "dev"
    Project     = "lab-simulation"
  }




}
module "api_gateway" {
  source = "../../modules/api_gateway"

  api_name   = "lab-api"
  lambda_arn = module.lambda.lambda_arn
  route_key  = "GET /"
  stage_name = "$default"
}


module "lambda" {
  source = "../../modules/lambda"

  function_name = "lab-lambda"
  handler       = "index.handler"
  runtime       = "python3.9"
  role_arn = "module.iam.lambda_role_arn"
  filename = "${path.module}/../../envs/dev_staging_prod/lambda/lambda.zip"

}

#Test Comment For CI/CD 2