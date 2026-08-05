output "zone_id" {
  value       = google_dns_managed_zone.main.id
  description = "ID of the managed zone"
}

output "name_servers" {
  value       = google_dns_managed_zone.main.name_servers
  description = "Authoritative name servers for the zone"
}

output "record_set_names" {
  value       = [for r in google_dns_record_set.records : r.name]
  description = "Names of the DNS record sets created in the zone"
}