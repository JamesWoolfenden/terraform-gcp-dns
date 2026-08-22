# holden:ignore:HLD_TF_026 — examples intentionally use ../../ to reference the local module root
module "dns" {
  source      = "../../"
  zone_name   = "holden-test-zone"
  dns_name    = "holden-test.example.com."
  description = "Example zone exercising holden's gcp/dns policy set"

  labels = {
    owner      = "holden"
    managed_by = "terraform"
  }

  records = [
    {
      name    = "www"
      type    = "A"
      ttl     = 300
      rrdatas = ["203.0.113.10"]
    },
    {
      name    = "mail"
      type    = "MX"
      ttl     = 3600
      rrdatas = ["10 mail.holden-test.example.com."]
    },
    {
      name    = "holden-test.example.com."
      type    = "TXT"
      ttl     = 300
      rrdatas = ["\"v=spf1 -all\""]
    },
    {
      name    = "holden-test.example.com."
      type    = "CAA"
      ttl     = 3600
      rrdatas = ["0 issue \"letsencrypt.org\""]
    },
    {
      name    = "_dmarc.holden-test.example.com."
      type    = "TXT"
      ttl     = 300
      rrdatas = ["\"v=DMARC1; p=reject; rua=mailto:dmarc-reports@holden-test.example.com\""]
    }
  ]

  iam_members = [
    {
      role   = "roles/dns.reader"
      member = "serviceAccount:reader@holden-test.iam.gserviceaccount.com"
    }
  ]
}
