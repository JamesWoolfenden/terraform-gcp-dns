# terraform-gcp-dns

[![Build Status](https://github.com/JamesWoolfenden/terraform-gcp-dns/workflows/Verify/badge.svg?branch=master)](https://github.com/JamesWoolfenden/terraform-gcp-dns)
[![Latest Release](https://img.shields.io/github/release/JamesWoolfenden/terraform-gcp-dns.svg)](https://github.com/JamesWoolfenden/terraform-gcp-dns/releases/latest)
[![GitHub tag (latest SemVer)](https://img.shields.io/github/tag/JamesWoolfenden/terraform-gcp-dns.svg?label=latest)](https://github.com/JamesWoolfenden/terraform-gcp-dns/releases/latest)
![Terraform Version](https://img.shields.io/badge/tf-%3E%3D1.5.0-blue.svg)
[![pre-commit](https://img.shields.io/badge/pre--commit-enabled-brightgreen?logo=pre-commit&logoColor=white)](https://github.com/pre-commit/pre-commit)
[![checkov](https://img.shields.io/badge/checkov-verified-brightgreen)](https://www.checkov.io/)

Terraform module for a Cloud DNS managed zone: DNSSEC-signed, query logging
enabled, with optional record sets and IAM member bindings. Exercises
holden's `policies/gcp/dns` policy set.

## Usage

Add **module.dns.tf** to your code:

```terraform
module "dns" {
  source      = "JamesWoolfenden/dns/gcp"
  version     = "0.1.0"
  zone_name   = "example-zone"
  dns_name    = "example.com."
  description = "Public zone for example.com"

  labels = {
    owner = "platform-team"
  }

  records = [
    {
      name    = "www"
      type    = "A"
      ttl     = 300
      rrdatas = ["203.0.113.10"]
    }
  ]

  iam_members = [
    {
      role   = "roles/dns.reader"
      member = "serviceAccount:reader@my-project.iam.gserviceaccount.com"
    }
  ]
}
```

Record `name` may be relative (`"www"`) or fully-qualified (`"www.example.com."`);
relative names are anchored to `var.dns_name`.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
| ---- | ------- |
| <a name="provider_google"></a> [google](#provider\_google) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
| ---- | ---- |
| [google_dns_managed_zone.main](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone) | resource |
| [google_dns_managed_zone_iam_member.members](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_managed_zone_iam_member) | resource |
| [google_dns_record_set.records](https://registry.terraform.io/providers/hashicorp/google/latest/docs/resources/dns_record_set) | resource |

## Inputs

| Name | Description | Type | Default | Required |
| ---- | ----------- | ---- | ------- | :------: |
| <a name="input_description"></a> [description](#input\_description) | Description of the managed zone | `string` | `"Managed by terraform-gcp-dns"` | no |
| <a name="input_dns_name"></a> [dns\_name](#input\_dns\_name) | DNS name of the managed zone, e.g. example.com. | `string` | n/a | yes |
| <a name="input_enable_query_logging"></a> [enable\_query\_logging](#input\_enable\_query\_logging) | Enable Cloud Logging for DNS queries served by this zone | `bool` | `true` | no |
| <a name="input_iam_members"></a> [iam\_members](#input\_iam\_members) | IAM members granted access to the managed zone, e.g. { role = "roles/dns.reader", member = "serviceAccount:sa@project.iam.gserviceaccount.com" } | <pre>list(object({<br/>  role   = string<br/>  member = string<br/>}))</pre> | `[]` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | Labels to apply to the managed zone | `map(string)` | `{}` | no |
| <a name="input_records"></a> [records](#input\_records) | DNS record sets to create in the zone. name may be relative ("www") or fully-qualified ("www.example.com."); relative names are anchored to var.dns\_name. | <pre>list(object({<br/>  name    = string<br/>  type    = string<br/>  ttl     = number<br/>  rrdatas = list(string)<br/>}))</pre> | `[]` | no |
| <a name="input_zone_name"></a> [zone\_name](#input\_zone\_name) | Name of the Cloud DNS managed zone | `string` | n/a | yes |

## Outputs

| Name | Description |
| ---- | ----------- |
| <a name="output_name_servers"></a> [name\_servers](#output\_name\_servers) | Authoritative name servers for the zone |
| <a name="output_record_set_names"></a> [record\_set\_names](#output\_record\_set\_names) | Names of the DNS record sets created in the zone |
| <a name="output_zone_id"></a> [zone\_id](#output\_zone\_id) | ID of the managed zone |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Related Projects

Check out these related projects.

- [terraform-aws-codecommit](https://github.com/jameswoolfenden/terraform-aws-codebuild) - Storing ones code

## Help

**Got a question?**

File a GitHub [issue](https://github.com/jameswoolfenden/terraform-gcp-dns/issues).

## Contributing

### Bug Reports & Feature Requests

Please use the [issue tracker](https://github.com/jameswoolfenden/terraform-gcp-dns/issues) to report any bugs or file feature requests.

## Copyrights

Copyright © 2019-2026 James Woolfenden

## License

[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

See [LICENSE](LICENSE) for full details.

Licensed to the Apache Software Foundation (ASF) under one
or more contributor license agreements. See the NOTICE file
distributed with this work for additional information
regarding copyright ownership. The ASF licenses this file
to you under the Apache License, Version 2.0 (the
"License"); you may not use this file except in compliance
with the License. You may obtain a copy of the License at

<https://www.apache.org/licenses/LICENSE-2.0>

Unless required by applicable law or agreed to in writing,
software distributed under the License is distributed on an
"AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
KIND, either express or implied. See the License for the
specific language governing permissions and limitations
under the License.

### Contributors

[![James Woolfenden][jameswoolfenden_avatar]][jameswoolfenden_homepage]<br/>[James Woolfenden][jameswoolfenden_homepage]

[jameswoolfenden_homepage]: https://github.com/jameswoolfenden
[jameswoolfenden_avatar]: https://github.com/jameswoolfenden.png?size=150
