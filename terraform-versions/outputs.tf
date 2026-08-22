# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "domain_name" {
  description = "Public DNS name of the Azure VM."
  value       = azurerm_public_ip.web.fqdn
}

output "application_url" {
  description = "URL of the example application."
  value       = "http://${azurerm_public_ip.web.fqdn}/index.php"
}
