locals {
  common_tags = {
    "environment"   = var.environment
    "managed_by_tf" = "true"
  }

  resource_name = "nginx-${var.environment}"
}