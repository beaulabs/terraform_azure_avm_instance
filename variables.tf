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
  default     = "sandbox"
}

variable "public_ip_dns" {
  description = "Optional globally unique per datacenter region domain name label to apply to each public ip address. e.g. thisvar.varlocation.cloudapp.azure.com where you specify only thisvar here. This is an array of names which will pair up sequentially to the number of public ips defined in var.nb_public_ip. One name or empty string is required for every public ip. If no public ip is desired, then set this to an array with a single empty string."
  default     = [""]
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
