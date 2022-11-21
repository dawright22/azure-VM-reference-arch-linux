output "Net-vm-ref-arch" {
  value = azurerm_virtual_network.vm-ref-arch
}

output "subnet1" {
  value = azurerm_subnet.app_gateway_sub.id
}

output "subnet2" {
  value = azurerm_subnet.mgmt_sub.id
}

output "subnet3" {
  value = azurerm_subnet.web_tier_sub.id
}


output "subnet4" {
  value = azurerm_subnet.biz_tier_sub.id
}

output "subnet5" {
  value = azurerm_subnet.data_tier_sub.id
}

output "app-nsg" {
  value = azurerm_network_security_group.SecurityGroup
}

output "mgmt-nsg" {
  value = azurerm_network_security_group.SecurityGroup1
}

output "web-nsg" {
  value = azurerm_network_security_group.SecurityGroup2
}

output "biz-nsg" {
  value = azurerm_network_security_group.SecurityGroup3
}

output "data-nsg" {
  value = azurerm_network_security_group.SecurityGroup4
}

output "app-gtw-ip" {
  value = azurerm_public_ip.app-gateway.id
}

output "private_dns_zone" {
  value = azurerm_private_dns_zone.default.id
}

output "private_dns_zone_link" {
  value = azurerm_private_dns_zone_virtual_network_link.default
}
