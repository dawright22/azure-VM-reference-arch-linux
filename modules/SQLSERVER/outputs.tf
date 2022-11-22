output "sqlserver-id" {
  value = azurerm_mssql_server.sqlserver.id
}

output "sqlserver-fqdn" {
  value = azurerm_mssql_server.sqlserver.fully_qualified_domain_name
}

# output "cosmos-db-id" {
#   value = azurerm_cosmosdb_account.Storacc.id
# }

# output "cosmos-db-endpoint" {
#   value = azurerm_cosmosdb_account.Storacc.endpoint
# }

# output "cosmos-db-endpoints_read" {
#   value = azurerm_cosmosdb_account.Storacc.read_endpoints
# }

# output "cosmos-db-endpoints_write" {
#   value = azurerm_cosmosdb_account.Storacc.write_endpoints
# }