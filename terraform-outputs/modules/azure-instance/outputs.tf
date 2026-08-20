# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "instance_ids" {
  description = "IDs of the created Virtual Machines"
  value       = azurerm_linux_virtual_machine.app[*].id
}
