resource "google_dns_managed_zone" "main" {
  name        = var.zone_name
  dns_name    = var.dns_name
  description = var.description
  labels      = var.labels

  cloud_logging_config {
    enable_logging = var.enable_query_logging
  }

  dnssec_config {
    state = "on"

    default_key_specs {
      algorithm  = "rsasha256"
      key_type   = "keySigning"
      key_length = 2048
    }

    default_key_specs {
      algorithm  = "rsasha256"
      key_type   = "zoneSigning"
      key_length = 1024
    }
  }
}