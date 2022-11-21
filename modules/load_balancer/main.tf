resource "azurerm_lb" "web_tier_lb" {
  name                = "${var.name}-lb"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  frontend_ip_configuration {
    name      = "${var.name}-lb"
    subnet_id = var.lb_sub
  }
}

resource "azurerm_lb_backend_address_pool" "web_tier_lb" {
  loadbalancer_id = azurerm_lb.web_tier_lb.id
  name            = "${var.name}BackEndAddressPool"
}

resource "azurerm_lb_probe" "web_tier_lb" {
  loadbalancer_id = azurerm_lb.web_tier_lb.id
  name            = "web-running-probe"
  port            = 80
}

resource "azurerm_lb_nat_rule" "ssh-nat" {
  resource_group_name            = var.resource_group_name
  loadbalancer_id                = azurerm_lb.web_tier_lb.id
  name                           = "SSHAccess"
  protocol                       = "Tcp"
  frontend_port_start            = 5000
  frontend_port_end              = 5500
  backend_port                   = 22
  backend_address_pool_id        = azurerm_lb_backend_address_pool.web_tier_lb.id
  frontend_ip_configuration_name = "${var.name}-lb"
}

resource "azurerm_lb_rule" "web_tier_lb" {
  loadbalancer_id                = azurerm_lb.web_tier_lb.id
  name                           = "${var.name}-LBRule"
  protocol                       = "Tcp"
  frontend_port                  = 80
  backend_port                   = 80
  backend_address_pool_ids       = [azurerm_lb_backend_address_pool.web_tier_lb.id]
  frontend_ip_configuration_name = "${var.name}-lb"
}