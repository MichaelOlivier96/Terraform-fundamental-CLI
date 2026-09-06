# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location

  tags = {
    hashicorp-learn = "console"
  }
}

resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_storage_account" "data" {
  name                     = "${var.storage_account_prefix}${random_string.suffix.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    hashicorp-learn = "console"
  }
}

resource "azurerm_storage_container" "data" {
  name                  = "data-container"
  storage_account_name  = azurerm_storage_account.data.name
  container_access_type = "blob" # Grants public read access for blobs
}

data "azurerm_storage_account" "data" {
  name                = azurerm_storage_account.data.name
  resource_group_name = azurerm_resource_group.rg.name
}

# Fetch current tenant & principal identity details
data "azurerm_client_config" "current" {}

# Assign 'Storage Blob Data Reader' role at the container scope
resource "azurerm_role_assignment" "container_reader" {
  scope                = azurerm_storage_container.data.resource_manager_id
  role_definition_name = "Storage Blob Data Reader"
  principal_id         = data.azurerm_client_config.current.object_id
}
