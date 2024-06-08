variable "db_username" {
  description = "RDS root user name"
  type        = string
}

variable "db_password" {
  description = "RDS root user password"
  type        = string
  sensitive   = true
}

variable "frontend_domain" {
  description = "Frontend domain name"
  type        = string
}

variable "backend_domain" {
  description = "Backend domain name"
  type        = string
}

variable "metabase_domain" {
  description = "Metabase domain name"
  type        = string
}

variable "frontend_port" {
  description = "Frontend port"
  type        = string
}

variable "backend_port" {
  description = "Backend port"
  type        = string
}

variable "metabase_port" {
  description = "Metabase port"
  type        = string
}
