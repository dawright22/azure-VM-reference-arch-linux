output "cosmos-db-id" {
  value = azurerm_cosmosdb_account.Storacc.id
}

output "cosmos-db-endpoint" {
  value = azurerm_cosmosdb_account.Storacc.endpoint
}

output "cosmos-db-endpoints_read" {
  value = azurerm_cosmosdb_account.Storacc.read_endpoints
}

output "cosmos-db-endpoints_write" {
  value = azurerm_cosmosdb_account.Storacc.write_endpoints
}