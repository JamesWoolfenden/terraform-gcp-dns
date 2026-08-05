resource "google_dns_record_set" "records" {
  for_each = { for r in var.records : "${r.name}-${r.type}" => r }

  managed_zone = google_dns_managed_zone.main.name
  name         = endswith(each.value.name, ".") ? each.value.name : "${each.value.name}.${var.dns_name}"
  type         = each.value.type
  ttl          = each.value.ttl
  rrdatas      = each.value.rrdatas
}
