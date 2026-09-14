variable "function_name" {
  type        = string
  description = "Name of the Lambda function"
}

variable "handler" {
  type        = string
  description = "Lambda handler entrypoint"
}

variable "runtime" {
  type        = string
  description = "Lambda runtime (e.g., python3.9)"
}

variable "filename" {
  type        = string
  description = "Path to the Lambda deployment package"
}

variable "environment_variables" {
  type    = map(string)
  default = {}
}

variable "log_retention" {
  type        = number
  default     = 14
  description = "CloudWatch log retention in days"
}

variable "tags" {
  type    = map(string)
  default = {}
}

variable "role_arn" {
  type = string
}
variable "api_execution_arn" {
  type = string
}
