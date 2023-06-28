variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "subnet_id" {
  description = "ID of the subnet"
}

variable "vm_count" {
  description = "Number of virtual machines"
  default     = 3
}

resource "azurerm_linux_virtual_machine" "vm" {
  count                = var.vm_count
  name                 = "my-vm-${count.index}"
  resource_group_name  = var.resource_group_name
  location             = var.resource_group_name
  size                 = "Standard_D2ds_v4"
  admin_username       = "adminuser"
  admin_password       = "adminpassword"
  disable_password_authentication = false

  network_interface {
    name                      = "nic-${count.index}"
    location                  = var.resource_group_name
    resource_group_name       = var.resource_group_name
    subnet_id                 = var.subnet_id
    private_ip_address_allocation = "Dynamic"
  }

  os_disk {
    caching                  = "ReadWrite"
    storage_account_type     = "Standard_LRS"
  }

  source_image_reference {
    publisher                = "Canonical"
    offer                    = "0001-com-ubuntu-server-jammy"
    sku                      = "22_04-lts"
    version                  = "latest"
  }

  boot_diagnostics {
    enabled                  = true
    storage_account_uri      = azurerm_storage_account.bootdiagsa.primary_blob_endpoint
  }
}

resource "azurerm_public_ip" "public_ip" {
  count                = var.vm_count
  name                 = "publicip-${count.index}"
  resource_group_name  = var.resource_group_name
  location             = var.resource_group_name
  allocation_method    = "Dynamic"
  sku                  = "Standard"
}

resource "azurerm_network_interface" "nic" {
  count                = var.vm_count
  name                 = "nic-${count.index}"
  location             = var.resource_group_name
  resource_group_name  = var.resource_group_name

  ip_configuration {
    name                          = "ipconfig-${count.index}"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public_ip[count.index].id
  }
}
