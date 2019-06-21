# Variables for deploying an Azure virtual machine instance

variable "prefix" {
  description = "The prefix you want to prepend resources with"
  default     = "beaulabs"
}

variable "location" {
  description = "Region you want to deploy resources into"
  default     = "west us"
}

variable "avm_name" {
  description = "Name of the virtual machine"
  default     = "midnight"
}

variable "admin_name" {
  description = "The admin name you want to use to access vm if not using ssh key"
  default     = "beau"
}

variable "adminpasswd" {
  description = "The admin password you want to use if not using ssh keys for Linux vm"
}

variable "tags" {
  description = "Tags to use on resources"
  type        = "map"

  default = {
    environment = "development"
    owner       = "beau"
    ttl         = "48"
  }
}
