# We strongly recommend using the required_providers block to set the
# Azure Provider source and version being used
terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.26.0"
    }
    # random = {
    #   source  = "hashicorp/random"
    #   version = "~>3.0"
    # }
  }
}


provider "azurerm" {
  features {}
}

resource "random_pet" "name" {
  prefix = var.resource_group_name_prefix
  length = 1
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "random_password" "dbpassword" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

######################################
# Create Resource Group.
######################################

resource "azurerm_resource_group" "rg" {
  location = var.resource_group_location
  name     = "${random_pet.name.id}.rg"
}

######################################
# Create networks
######################################

module "networks" {
  source                  = "./modules/networks"
  name                    = random_pet.name.id
  resource_group_location = var.resource_group_location
  resource_group_name     = azurerm_resource_group.rg.name
  remote_vnet             = module.bastion-host.bastion-vnet
  remote_vnet_name        = module.bastion-host.bastion-vnet-name
}

######################################
# Create Bastion Host
######################################

module "bastion-host" {
  source                  = "./modules/management_tools"
  name                    = random_pet.name.id
  resource_group_location = var.resource_group_location
  resource_group_name     = azurerm_resource_group.rg.name
}

######################################
# Create app_gateway
######################################

module "app-gateway" {
  source                  = "./modules/app_gateway"
  name                    = random_pet.name.id
  resource_group_location = var.resource_group_location
  resource_group_name     = azurerm_resource_group.rg.name
  app_gtw_sub             = module.networks.subnet1
  app_gtw_ip              = module.networks.app-gtw-ip
}

######################################
# Create private load_balancer
######################################

module "load_balancer" {
  source                  = "./modules/load_balancer"
  name                    = random_pet.name.id
  resource_group_location = var.resource_group_location
  resource_group_name     = azurerm_resource_group.rg.name
  lb_sub                  = module.networks.subnet3
}

######################################
# Create web scale set
######################################

module "web_scale_sets" {
  source                   = "./modules/web_scale_set"
  name                     = random_pet.name.id
  resource_group_location  = var.resource_group_location
  resource_group_name      = azurerm_resource_group.rg.name
  scale_set_sub            = module.networks.subnet3
  app_gty_backend_pool_ids = module.app-gateway.app_gateway.backend_address_pool[*].id
  admin_user               = var.admin_user
  admin_password           = random_password.password.bcrypt_hash
  # app provisioning
  web_image = "erjosito/yadaweb:1.0"
  api_private_ip = module.load_balancer.mid_tier_lb.private_ip_address
}

######################################
# Create biz scale set
######################################

module "biz_scale_sets" {
  source                  = "./modules/biz_scale_set"
  name                    = random_pet.name.id
  resource_group_location = var.resource_group_location
  resource_group_name     = azurerm_resource_group.rg.name
  scale_set_sub           = module.networks.subnet4
  lb_backend_pool_ids     = module.load_balancer.lb_pool_ids
  admin_user              = var.admin_user
  admin_password          = random_password.password.bcrypt_hash
  # app provisioning
  api_image = "erjosito/yadaapi:1.0"
  SQL_SERVER_FQDN = module.db_SQLSERVER.sqlserver-fqdn
  SQL_SERVER_USERNAME = var.admin_user 
  SQL_SERVER_PASSWORD = random_password.password.bcrypt_hash


}

######################################
# Create Database.
######################################
# module "db_MySQL" {
#   source                  = "./modules/COSMOSDB"
#   name                    = random_pet.name.id
#   resource_group_location = var.resource_group_location
#   resource_group_name     = azurerm_resource_group.rg.name
#   throughput              = 400
#   data_tier_sub_id        = module.networks.subnet5
#   ip_range_filter         = "0.0.0.0"
# }
module "db_SQLSERVER" {
  source                  = "./modules/SQLSERVER"
  location                = var.resource_group_location
  resource_group_name     = azurerm_resource_group.rg.name
  servername                    = random_pet.name.id
  dbname = "mydb"
  adminlogin ="dbadmin"
  adminpwd = random_password.dbpassword.bcrypt_hash
}