variable "domain_name" {
  description = "Domain name used for the ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID used for DNS validation"
  type        = string
}

variable "validation_record_ttl" {
  description = "TTL in seconds for ACM DNS validation records"
  type        = number
  default     = 60

  validation {
    condition     = var.validation_record_ttl > 0
    error_message = "Validation record TTL must be greater than 0."
  }
}