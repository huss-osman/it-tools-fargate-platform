variable "domain_name" {
  description = "Domain name used for the ACM certificate"
  type        = string
}

variable "route53_zone_id" {
  description = "Route 53 hosted zone ID used for DNS validation"
  type        = string
}