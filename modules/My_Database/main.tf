resource "azurerm_cosmosdb_account" "Storacc" {
  name                              = "${var.name}-cosmosdb-acc"
  location                          = var.resource_group_location
  resource_group_name               = var.resource_group_name
  offer_type                        = "Standard"
  kind                              = "GlobalDocumentDB"
  enable_automatic_failover         = false
  enable_free_tier                  = true
  is_virtual_network_filter_enabled = "true"
  ip_range_filter                   = var.ip_range_filter
  virtual_network_rule {
    id                                   = var.data_tier_sub_id
    ignore_missing_vnet_service_endpoint = true
  }
  geo_location {
    location          = var.resource_group_location
    failover_priority = 0
  }
  consistency_policy {
    consistency_level       = "BoundedStaleness"
    max_interval_in_seconds = 300
    max_staleness_prefix    = 100000
  }
  depends_on = [
    var.resource_group_name,
    var.data_tier_sub_id
  ]
}

resource "azurerm_cosmosdb_sql_database" "cossqldb" {
  name                = "${var.name}-cosmosdb-sqldb"
  resource_group_name = var.resource_group_name
  account_name        = azurerm_cosmosdb_account.Storacc.name
  throughput          = var.throughput
}

resource "azurerm_cosmosdb_sql_container" "cosssqlcont" {
  name                  = "${var.name}-cosmosdb-sql-container"
  resource_group_name   = var.resource_group_name
  account_name          = azurerm_cosmosdb_account.Storacc.name
  database_name         = azurerm_cosmosdb_sql_database.cossqldb.name
  partition_key_path    = "/definition/id"
  partition_key_version = 1
  throughput            = var.throughput

  indexing_policy {
    indexing_mode = "consistent"

    included_path {
      path = "/*"
    }

    included_path {
      path = "/included/?"
    }

    excluded_path {
      path = "/excluded/?"
    }
  }

  unique_key {
    paths = ["/definition/idlong", "/definition/idshort"]
  }
}
