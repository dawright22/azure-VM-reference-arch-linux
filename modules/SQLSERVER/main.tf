resource "azurerm_mssql_server" "sqlserver" {
  name                         = "${var.servername}-sqlserver-acc"
  resource_group_name          = var.resource_group_name
  location                     = var.location
  version                      = "12.0"
  administrator_login          = var.adminlogin
  administrator_login_password = var.adminpwd
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "${var.dbname}"
  server_id      = azurerm_mssql_server.sqlserver.id
  collation      = "SQL_Latin1_General_CP1_CI_AS"
  license_type   = "LicenseIncluded"
  sku_name       = "S0"

  //max_size_gb    = 4
  // read_scale     = true

  // zone_redundant = true

lifecycle {
  ignore_changes = [
      license_type                  
  ]  
}


}


