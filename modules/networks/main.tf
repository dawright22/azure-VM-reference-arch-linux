######################################
# Create Public Ips
######################################
resource "azurerm_public_ip" "app-gateway" {
  name                = "${var.name}-app_gty_ip"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"

}

######################################
# Create Security Groups and Rules
######################################
resource "azurerm_network_security_group" "SecurityGroup" {
  name                = "${var.name}-SecurityGroup"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform"
  }
}

resource "azurerm_network_security_group" "SecurityGroup1" {
  name                = "${var.name}-SecurityGroup1"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform"
  }
}

resource "azurerm_network_security_group" "SecurityGroup2" {
  name                = "${var.name}-SecurityGroup2"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform"
  }
}

resource "azurerm_network_security_group" "SecurityGroup3" {
  name                = "${var.name}-SecurityGroup3"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform"
  }
}

resource "azurerm_network_security_group" "SecurityGroup4" {
  name                = "${var.name}-SecurityGroup4"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name


  security_rule {
    name                       = var.name
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }

  tags = {
    environment = "Terraform"
  }
}



######################################
# Create VNet and SubNets
######################################


resource "azurerm_virtual_network" "vm-ref-arch" {
  name                = "${var.name}-network"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
  tags = {
    environment = "Terraform"
  }
}

resource "azurerm_subnet" "app_gateway_sub" {
  name                 = "${var.name}-app_gateway_sub"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm-ref-arch.name
  address_prefixes     = ["10.0.1.0/24"]

}
resource "azurerm_subnet" "mgmt_sub" {
  name                 = "${var.name}-mgmt_sub"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm-ref-arch.name
  address_prefixes     = ["10.0.2.0/24"]

}
resource "azurerm_subnet" "web_tier_sub" {
  name                 = "${var.name}-web_tier_sub"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm-ref-arch.name
  address_prefixes     = ["10.0.3.0/24"]


}
resource "azurerm_subnet" "biz_tier_sub" {
  name                 = "${var.name}-biz_tier_sub"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm-ref-arch.name
  address_prefixes     = ["10.0.4.0/24"]

}

resource "azurerm_subnet" "data_tier_sub" {
  name                 = "${var.name}-data_tier_sub"
  resource_group_name  = var.resource_group_name
  virtual_network_name = azurerm_virtual_network.vm-ref-arch.name
  address_prefixes     = ["10.0.5.0/24"]
  service_endpoints    = ["Microsoft.AzureCosmosDB"]
}

resource "azurerm_subnet_network_security_group_association" "SGA" {
  subnet_id                 = azurerm_subnet.app_gateway_sub.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup.id
}
resource "azurerm_subnet_network_security_group_association" "SGA1" {
  subnet_id                 = azurerm_subnet.mgmt_sub.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup1.id
}
resource "azurerm_subnet_network_security_group_association" "SGA2" {
  subnet_id                 = azurerm_subnet.web_tier_sub.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup2.id
}
resource "azurerm_subnet_network_security_group_association" "SGA3" {
  subnet_id                 = azurerm_subnet.biz_tier_sub.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup3.id
}
resource "azurerm_subnet_network_security_group_association" "SGA4" {
  subnet_id                 = azurerm_subnet.data_tier_sub.id
  network_security_group_id = azurerm_network_security_group.SecurityGroup4.id
}

######################################
# Create Private DNS
######################################
# Enables you to manage Private DNS zones within Azure DNS
resource "azurerm_private_dns_zone" "default" {
  name                = "${var.name}.mysql.database.azure.com"
  resource_group_name = var.resource_group_name
}

# Enables you to manage Private DNS zone Virtual Network Links
resource "azurerm_private_dns_zone_virtual_network_link" "default" {
  name                  = "mysqlfsVnetZone${var.name}.com"
  private_dns_zone_name = azurerm_private_dns_zone.default.name
  resource_group_name   = var.resource_group_name
  virtual_network_id    = azurerm_virtual_network.vm-ref-arch.id
}

######################################
# Create Vnet peering 
######################################

resource "azurerm_virtual_network_peering" "peering" {
  name                         = "peerA2peerB"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = azurerm_virtual_network.vm-ref-arch.name
  remote_virtual_network_id    = var.remote_vnet
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}

resource "azurerm_virtual_network_peering" "peering2" {
  name                         = "peerB2peerA"
  resource_group_name          = var.resource_group_name
  virtual_network_name         = var.remote_vnet_name
  remote_virtual_network_id    = azurerm_virtual_network.vm-ref-arch.id
  allow_virtual_network_access = true
  allow_forwarded_traffic      = true

  # `allow_gateway_transit` must be set to false for vnet Global Peering
  allow_gateway_transit = false
}