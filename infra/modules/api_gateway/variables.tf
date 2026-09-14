variable "api_name" {
  type        = string
  description = "Name of the API Gateway"
}

variable "lambda_arn" {
  type        = string
  description = "ARN of the Lambda function to integrate"
}

variable "route_key" {
  type        = string
  default     = "GET /"
  description = "Route key (e.g., GET /hello)"
}

variable "stage_name" {
  type        = string
  default     = "$default"
  description = "Deployment stage name"
}
variable "stage" {
  type = object({
    name = string
  })
}
