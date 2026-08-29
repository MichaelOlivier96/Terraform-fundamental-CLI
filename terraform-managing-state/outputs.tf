output "instance_id" {
  value       = azurerm_linux_virtual_machine.example.id
  description = "The ID of the Azure VM"
}

output "public_ip" {
  value       = azurerm_public_ip.example.ip_address
  description = "The public IP of the web server"
}

output "location" {
  value       = var.location
  description = "Azure location for all resources"
}

output "security_group" {
  value       = azurerm_network_security_group.sg_8080.id
  description = "The security group for the Azure instance"
}
