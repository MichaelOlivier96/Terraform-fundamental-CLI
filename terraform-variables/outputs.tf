# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

output "public_dns_name" {
  description = "Public FQDN / DNS name of the Azure Load Balancer"
  value       = azurerm_public_ip.lb_pip.fqdn
}
