# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Input variables

variable "location" {
  description = "Azure region location"
  type        = string
  default     = "eastus"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
  default     = "rg-terraform-console"
}

variable "storage_account_prefix" {
  description = "Prefix for storage account name (lowercase alphanumeric only)."
  type        = string
  default     = "hashilearn"
}
