# Variables for deploying an Azure virtual machine instance

variable "prefix" {
  description = "The prefix you want to prepend resources with"
  default     = "beau"
}

variable "location" {
  description = "Region you want to deploy resources into"
  default     = "central us"
}

variable "avm_name" {
  description = "Name of the virtual machine"
  default     = "demobox"
}

variable "admin_name" {
  description = "The admin name you want to use to access vm if not using ssh key"
  default     = "beau"
}

variable "adminpasswd" {
  description = "The admin password you want to use if not using ssh keys for Linux vm"

}

variable "vmsize" {
  description = "The size of virtual machine desired"
  default     = "Standard_B1ms"
}

variable "tags" {
  description = "Tags to use on resources"
  type        = map(string)

  default = {
    environment = "development"
    #owner       = "beau"
    ttl = "48"
  }
}

