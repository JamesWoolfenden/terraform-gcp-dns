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

variable "description" {
  type        = string
  description = "Description of the managed zone"
  default     = "Managed by terraform-gcp-dns"

  validation {
    condition     = length(trimspace(var.description)) > 0
    error_message = "var.description must be a non-empty string"
  }
}

variable "labels" {
  type        = map(string)
  description = "Labels to apply to the managed zone"
  default     = {}

  validation {
    condition     = alltrue([for k, v in var.labels : can(regex("^[a-z0-9_-]{1,63}$", k)) && can(regex("^[a-z0-9_-]{0,63}$", v))])
    error_message = "labels keys and values must be lowercase alphanumerics, underscores or dashes, up to 63 characters"
  }
}

variable "enable_query_logging" {
  type        = bool
  description = "Enable Cloud Logging for DNS queries served by this zone"
  default     = true
}

variable "records" {
  type = list(object({
    name    = string
    type    = string
    ttl     = number
    rrdatas = list(string)
  }))
  description = "DNS record sets to create in the zone. name may be relative (\"www\") or fully-qualified (\"www.example.com.\"); relative names are anchored to var.dns_name."
  default     = []

  validation {
    condition     = alltrue([for r in var.records : contains(["A", "AAAA", "CNAME", "MX", "TXT", "NS", "SRV", "CAA", "PTR"], r.type)])
    error_message = "each record's type must be one of: A, AAAA, CNAME, MX, TXT, NS, SRV, CAA, PTR"
  }

  validation {
    condition     = alltrue([for r in var.records : r.ttl > 0])
    error_message = "each record's ttl must be greater than 0"
  }

  validation {
    condition     = alltrue([for r in var.records : length(r.rrdatas) > 0])
    error_message = "each record must have at least one entry in rrdatas"
  }
}

variable "iam_members" {
  type = list(object({
    role   = string
    member = string
  }))
  description = "IAM members granted access to the managed zone, e.g. { role = \"roles/dns.reader\", member = \"serviceAccount:sa@project.iam.gserviceaccount.com\" }"
  default     = []

  validation {
    condition     = alltrue([for m in var.iam_members : startswith(m.role, "roles/")])
    error_message = "each iam_members role must start with 'roles/'"
  }

  validation {
    condition     = alltrue([for m in var.iam_members : !contains(["allUsers", "allAuthenticatedUsers"], m.member)])
    error_message = "iam_members must not grant access to allUsers or allAuthenticatedUsers"
  }
}
