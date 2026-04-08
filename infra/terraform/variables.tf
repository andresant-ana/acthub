variable "environment" {
  description = "Environment name (e.g., dev, staging, prod)"
  type        = string
  default     = "dev"
}

variable "location" {
  description = "Azure region"
  type        = string
  default     = "brazilsouth"
}

variable "db_admin_user" {
  description = "PostgreSQL administrator username"
  type        = string
  sensitive   = true
}

variable "db_admin_password" {
  description = "PostgreSQL administrator password"
  type        = string
  sensitive   = true
}