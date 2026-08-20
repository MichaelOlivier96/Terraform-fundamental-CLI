# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Output declarations

output "vnet_id" {
  description = "ID of project VNet"
  value       = azurerm_virtual_network.main.id
}

output "lb_url" {
  description = "URL of load balancer"
  value       = "http://${azurerm_public_ip.lb_pip.fqdn}/"
}

output "web_server_count" {
  description = "Number of web servers provisioned"
  value       = length(module.vm_instances.instance_ids)
}

output "db_username" {
  description = "Database administrator username"
  value       = azurerm_mysql_flexible_server.database.administrator_login
  sensitive   = true
}

output "db_password" {
  description = "Database administrator password"
  value       = azurerm_mysql_flexible_server.database.administrator_password
  sensitive   = true
}
