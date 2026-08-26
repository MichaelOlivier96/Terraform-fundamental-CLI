# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Output declarations

output "storage_account_name" {
  description = "Name of the Azure Storage Account"
  value       = azurerm_storage_account.sa.name
}

output "storage_container_name" {
  description = "Name of the Azure Storage Container"
  value       = azurerm_storage_container.container.name
}
