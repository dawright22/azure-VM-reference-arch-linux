######################################
# Create scale_set tier scale set
######################################

resource "azurerm_linux_virtual_machine_scale_set" "biz_scale_set" {
  name                            = "${var.name}-biz-vmss"
  resource_group_name             = var.resource_group_name
  location                        = var.resource_group_location
  sku                             = "Standard_B2s"
  instances                       = 3
  admin_username                  = var.admin_user
  admin_password                  = var.admin_password
  disable_password_authentication = false

  source_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18_04-lts-gen2"
    version   = "latest"
  }

  network_interface {
    name    = "${var.name}-network-int"
    primary = true

    ip_configuration {
      name                                   = "internal"
      primary                                = true
      subnet_id                              = var.scale_set_sub
      load_balancer_backend_address_pool_ids = [var.lb_backend_pool_ids]
    }
  }

  os_disk {
    storage_account_type = "Standard_LRS"
    caching              = "ReadWrite"
  }

  # Since these can change via auto-scaling outside of Terraform,
  # let's ignore any changes to the number of instances
  lifecycle {
    ignore_changes = [instances]
  }
}

resource "azurerm_monitor_autoscale_setting" "biz_scale_set_mon" {
  name                = "${var.name}-biz-autoscale-config"
  resource_group_name = var.resource_group_name
  location            = var.resource_group_location
  target_resource_id  = azurerm_linux_virtual_machine_scale_set.biz_scale_set.id

  profile {
    name = "BizAutoScale"

    capacity {
      default = 1
      minimum = 1
      maximum = 5
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.biz_scale_set.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "GreaterThan"
        threshold          = 75
      }

      scale_action {
        direction = "Increase"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }

    rule {
      metric_trigger {
        metric_name        = "Percentage CPU"
        metric_resource_id = azurerm_linux_virtual_machine_scale_set.biz_scale_set.id
        time_grain         = "PT1M"
        statistic          = "Average"
        time_window        = "PT5M"
        time_aggregation   = "Average"
        operator           = "LessThan"
        threshold          = 25
      }

      scale_action {
        direction = "Decrease"
        type      = "ChangeCount"
        value     = "1"
        cooldown  = "PT1M"
      }
    }
  }
}
