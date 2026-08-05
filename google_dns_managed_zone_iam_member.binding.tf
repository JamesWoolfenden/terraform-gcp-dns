resource "google_dns_managed_zone_iam_member" "members" {
  for_each = { for m in var.iam_members : "${m.role}-${m.member}" => m }

  managed_zone = google_dns_managed_zone.main.name
  role         = each.value.role
  member       = each.value.member
}
