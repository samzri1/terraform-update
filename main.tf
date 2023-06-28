provider "azurerm" {
  features {}
}

module "resource_group" {
  source     = "terraform-azurerm-resource-group"
  name       = "sam-terraformgrp"
  location   = "francecentral"
}

module "networking" {
  source                 = "./networking"
  network_resource_group_name = module.resource_group.name
}

module "virtual_machines" {
  source             = "./virtual_machines"
  vm_resource_group_name = module.resource_group.name
  vm_subnet_id          = module.networking.subnet_id
  num_vms               = 3
}
