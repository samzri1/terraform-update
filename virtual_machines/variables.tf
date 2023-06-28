variable "vm_resource_group_name" {
  description = "Name of the resource group"
}

variable "vm_subnet_id" {
  description = "ID of the subnet"
}

variable "num_vms" {
  description = "Number of virtual machines"
  default     = 3
}
