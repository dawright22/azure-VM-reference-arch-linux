policy "deny-any-sql-database-ingress" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/deny-any-sql-database-ingress.sentinel?checksum=sha256:20ac4cc88299ea14472b8c39f88bf12e488cf348d8f6435a8e0e9fbc398dea47"
  enforcement_level = "advisory"
}

policy "deny-public-rdp-nsg-rules" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/deny-public-rdp-nsg-rules.sentinel?checksum=sha256:b07e2c47e2683c9b89a75f87dd9617806b257a0db7261881efe51ed5d5893357"
  enforcement_level = "advisory"
}

policy "deny-public-ssh-nsg-rules" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/deny-public-ssh-nsg-rules.sentinel?checksum=sha256:75c95bf1d6eb48153cb31f15c49c237bf7829549beebe20effa07bcdd3f3cb74"
  enforcement_level = "advisory"
}

policy "enforce-network-watcher-flow-log-retention-period" {
  source = "https://registry.terraform.io/v2/policies/hashicorp/azure-networking-terraform/1.0.2/policy/enforce-network-watcher-flow-log-retention-period.sentinel?checksum=sha256:9af52ce96a945ad794fbbdafb78cdc5bd4f331b8253ac99f1223703a69edb79d"
  enforcement_level = "advisory"
}
