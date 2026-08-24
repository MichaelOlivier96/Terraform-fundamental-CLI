# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

# Azure Storage Account names cannot contain hyphens (-), 
# so we remove the separator to ensure a valid name.
resource "random_pet" "petname" {
  length    = 3
  separator = ""
}

resource "azurerm_resource_group" "sample" {
  name     = "rg-${random_pet.petname.id}"
  location = "australiaeast"
}

resource "azurerm_storage_account" "sample" {
  name                     = "sa${random_pet.petname.id}"
  resource_group_name      = azurerm_resource_group.sample.name
  location                 = azurerm_resource_group.sample.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    public_bucket = "false"
  }
}
