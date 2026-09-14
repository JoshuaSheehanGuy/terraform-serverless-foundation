resource "aws_dynamodb_table" "this" {
  name         = var.table_name
  billing_mode = var.billing_mode

  hash_key = var.hash_key

  attribute {
    name = var.hash_key
    type = var.hash_key_type
  }

  # Optional TTL
  dynamic "ttl" {
    for_each = var.enable_ttl ? [1] : []
    content {
      attribute_name = var.ttl_attribute
      enabled        = true
    }
  }

  # Optional Global Secondary Indexes
  dynamic "global_secondary_index" {
    for_each = var.global_secondary_indexes
    content {
      name            = global_secondary_index.value.name
      hash_key        = global_secondary_index.value.hash_key
      projection_type = global_secondary_index.value.projection_type

      read_capacity  = global_secondary_index.value.read_capacity
      write_capacity = global_secondary_index.value.write_capacity
    }
  }

  tags = var.tags
}
