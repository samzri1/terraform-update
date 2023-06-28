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
