# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

## Output values

output "storage_account_name" {
  description = "Name of the Azure Storage Account"
  value       = azurerm_storage_account.example.name
}
