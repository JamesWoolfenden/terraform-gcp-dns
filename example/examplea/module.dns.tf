# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "dns" {
  source    = "../../"
  zone_name = "holden-test-zone"
  dns_name  = "holden-test.example.com."
}