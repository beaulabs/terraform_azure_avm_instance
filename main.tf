# Configure the Terraform backend to run commands from localhost
terraform {
  required_version = ">= 0.12.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "beaulabs"

    workspaces {
      name = "dev_azure_avm_instance"
    }
  }
}

# This is the main file to create/set resources to deploy an Azure virtual machine.

provider "azurerm" {
  version = ">=1.35.0"
}

# Create the required Azure resource group container.

resource "azurerm_resource_group" "avm_rg" {
  name     = "${var.prefix}-avm-rg"
  location = var.location
  tags     = var.tags
}

# Create the required virtual network components for virtual machine connectivity.

resource "azurerm_virtual_network" "avm_virtnet" {
  name                = "${var.prefix}-network"
  resource_group_name = azurerm_resource_group.avm_rg.name
  location            = var.location
  address_space       = ["10.0.0.0/16"]
  tags                = var.tags
}

resource "azurerm_subnet" "avm_subnet" {
  name                 = "default-eth0"
  resource_group_name  = azurerm_resource_group.avm_rg.name
  virtual_network_name = azurerm_virtual_network.avm_virtnet.name
  address_prefix       = "10.0.1.0/24"
}

resource "azurerm_public_ip" "avm_pub_ip" {
  name                = "${var.prefix}-pubip"
  location            = var.location
  resource_group_name = azurerm_resource_group.avm_rg.name
  allocation_method   = "Static"
  domain_name_label   = "${var.prefix}-${var.avm_name}"
  tags                = var.tags
}

resource "azurerm_network_interface" "avm_nic" {
  name                = "${var.prefix}-nic"
  location            = var.location
  resource_group_name = azurerm_resource_group.avm_rg.name
  tags                = var.tags

  ip_configuration {
    name                          = "eth0"
    subnet_id                     = azurerm_subnet.avm_subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.avm_pub_ip.id
  }
}

# Create the virtual machine

resource "azurerm_virtual_machine" "avm_vm" {
  name                  = "${var.prefix}-${var.avm_name}"
  location              = var.location
  resource_group_name   = azurerm_resource_group.avm_rg.name
  network_interface_ids = [azurerm_network_interface.avm_nic.id]
  vm_size               = "Standard_B2s"
  tags                  = var.tags

  storage_image_reference {
    publisher = "Canonical"
    offer     = "UbuntuServer"
    sku       = "18.04-LTS"
    version   = "latest"
  }

  storage_os_disk {
    name              = "${var.prefix}-${var.avm_name}-sda"
    caching           = "ReadWrite"
    create_option     = "FromImage"
    managed_disk_type = "Standard_LRS"
  }

  os_profile {
    computer_name  = "${var.prefix}-${var.avm_name}"
    admin_username = var.admin_name
    admin_password = var.adminpasswd
  }

  os_profile_linux_config {
    disable_password_authentication = false
    # Uncomment the ssh_keys lines below if you are using ssh_keys and have changed above value to 'true'
    # ssh_keys {
    #   path     = "/home/${var.admin_name}/.ssh/authorized_keys"
    #   key_data = "${file("~/.ssh/id_rsa.pub")}"
    # }
  }
}

