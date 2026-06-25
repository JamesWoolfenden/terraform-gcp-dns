variable "dns_name" {
  type        = string
  description = "DNS name of the managed zone, e.g. example.com."

  validation {
    condition     = can(regex("\\.$", var.dns_name))
    error_message = "var.dns_name must be a fully-qualified domain name ending in a dot"
  }
}

variable "zone_name" {
  type        = string
  description = "Name of the Cloud DNS managed zone"

  validation {
    condition     = length(trimspace(var.zone_name)) > 0
    error_message = "var.zone_name must be a non-empty string"
  }
}