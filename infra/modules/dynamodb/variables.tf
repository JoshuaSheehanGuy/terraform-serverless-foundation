variable "table_name" {
  type        = string
  description = "Name of the DynamoDB table"
}

variable "billing_mode" {
  type        = string
  default     = "PAY_PER_REQUEST"
  description = "Billing mode: PAY_PER_REQUEST or PROVISIONED"
}

variable "hash_key" {
  type        = string
  description = "Primary partition key"
}

variable "hash_key_type" {
  type        = string
  default     = "S"
  description = "Key type: S, N, or B"
}

variable "enable_ttl" {
  type        = bool
  default     = false
}

variable "ttl_attribute" {
  type        = string
  default     = "ttl"
}

variable "global_secondary_indexes" {
  type = list(object({
    name            = string
    hash_key        = string
    projection_type = string
    read_capacity   = number
    write_capacity  = number
  }))
  default = []
}

variable "tags" {
  type    = map(string)
  default = {}
}
