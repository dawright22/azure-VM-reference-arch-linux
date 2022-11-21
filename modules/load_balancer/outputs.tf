output "mid_tier_lb" {
  value = azurerm_lb.web_tier_lb
}

output "lb_pool_ids" {
  value = azurerm_lb_backend_address_pool.web_tier_lb.id
}