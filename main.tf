provider "azurerm" {
  features {}
}

module "resource_group" {
  source     = "terraform-azurerm-resource-group"
  name       = "sam-terraformgrp"
  location   = "francecentral"
}

module "networking" {
  source       = "./networking"
  resource_group_name = module.resource_group.name
}

module "virtual_machines" {
  source             = "./virtual_machines"
  resource_group_name = module.resource_group.name
  subnet_id          = module.networking.subnet_id
  vm_count           = 3
}
