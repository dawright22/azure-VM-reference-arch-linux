resource "azurerm_application_gateway" "network" {
  name                = "${var.name}-appgateway"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location

  sku {
    name = "Standard_v2"
    tier = "Standard_v2"

  }
  autoscale_configuration {
    min_capacity = 1
  }

  gateway_ip_configuration {
    name      = "my-gateway-ip-configuration"
    subnet_id = var.app_gtw_sub
  }

  frontend_port {
    name = "${var.name}-feport"
    port = 80
  }

  frontend_ip_configuration {
    name                 = "${var.name}-feip"
    public_ip_address_id = var.app_gtw_ip
  }

  backend_address_pool {
    name = "${var.name}-beap"
  }

  backend_http_settings {
    name                  = "${var.name}-httpst"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              = "Http"
    request_timeout       = 60
  }

  http_listener {
    name                           = "${var.name}-httplstn"
    frontend_ip_configuration_name = "${var.name}-feip"
    frontend_port_name             = "${var.name}-feport"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "${var.name}-rrqr"
    priority                   = 10
    rule_type                  = "Basic"
    http_listener_name         = "${var.name}-httplstn"
    backend_address_pool_name  = "${var.name}-beap"
    backend_http_settings_name = "${var.name}-httpst"
  }
}