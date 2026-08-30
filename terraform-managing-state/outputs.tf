output "location" {
  value       = var.location
  description = "Azure location for all resources"
}

output "security_group" {
  value       = azurerm_network_security_group.sg_8080.id
  description = "The security group for the Azure instance"
}
