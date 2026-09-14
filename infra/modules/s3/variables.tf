variable "bucket_name" {
  type        = string
  description = "Name of the S3 bucket"
}

variable "versioning_enabled" {
  type        = bool
  default     = true
  description = "Enable or disable versioning"
}

variable "tags" {
  type    = map(string)
  default = {}
}
