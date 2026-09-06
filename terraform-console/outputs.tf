# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Output values

output "storage_account_name" {
  description = "Name of our Azure Storage Account."
  value       = azurerm_storage_account.data.name
}

output "storage_container_name" {
  description = "Name of our Storage Container."
  value       = azurerm_storage_container.data.name
}

output "storage_account_id" {
  description = "Resource ID of the Azure Storage Account."
  value       = azurerm_storage_account.data.id
}

output "role_assignment_id" {
  description = "The ID of the Azure Role Assignment."
  value       = azurerm_role_assignment.container_reader.id
}
