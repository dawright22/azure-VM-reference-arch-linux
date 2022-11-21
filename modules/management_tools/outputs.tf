output "bastion_fqdn" {
  value = azurerm_bastion_host.bastion-host.dns_name
}

output "bastion-ip" {
  value = azurerm_public_ip.bastion-pip.ip_address
}

output "bastion-vnet" {
  value = azurerm_virtual_network.bastion-net.id
}

output "bastion-vnet-name" {
  value = azurerm_virtual_network.bastion-net.name
}