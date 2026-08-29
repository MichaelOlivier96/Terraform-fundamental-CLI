output "instance_id" {
  value       = azurerm_linux_virtual_machine.example_new.id
  description = "The ID of the Azure instance"
}

output "public_ip" {
  value       = azurerm_public_ip.example_new.ip_address
  description = "The public IP of the web server"
}
