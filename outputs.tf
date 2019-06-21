output "public_ip_address" {
  value = "${azurerm_public_ip.avm_pub_ip.ip_address}"
}

output "ssh_to_avm" {
  value = "ssh ${var.admin_name}@${azurerm_public_ip.avm_pub_ip.fqdn}"
}
