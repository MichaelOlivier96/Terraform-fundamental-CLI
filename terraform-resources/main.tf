# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-terraform-targeting"
  location = var.location

  tags = {
    hashicorp-learn = "resource-targeting"
  }
}

resource "random_string" "storage_name" {
  length  = 15
  special = false
  upper   = false
}

resource "azurerm_storage_account" "sa" {
  name                     = "stlearn${random_string.storage_name.result}"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_container" "container" {
  name                  = "content"
  storage_account_name  = azurerm_storage_account.sa.name
  container_access_type = "blob"
}

resource "random_pet" "object_names" {
  count = 4

  length    = 5
  separator = "_"
  prefix    = "learning"
}

resource "azurerm_storage_blob" "objects" {
  count = 4

  name                   = "${random_pet.object_names[count.index].id}.txt"
  storage_account_name   = azurerm_storage_account.sa.name
  storage_container_name = azurerm_storage_container.container.name
  type                   = "Block"
  source_content         = "Example object #${count.index}"
}
