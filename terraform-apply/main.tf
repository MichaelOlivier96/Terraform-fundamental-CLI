# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

provider "random" {}

provider "time" {}

# Base Azure Resource Group
resource "azurerm_resource_group" "base" {
  name     = "${var.project_name}-rg"
  location = var.location
}

# Random Generators
resource "random_pet" "instance" {
  length = 2
}

# Specifically to safely name the Storage Account
resource "random_string" "sa_suffix" {
  length  = 6
  special = false
  upper   = false
}

# Independent Storage Resource (Replaces S3 Bucket)
resource "azurerm_storage_account" "example" {
  name                     = "sa${random_string.sa_suffix.result}"
  resource_group_name      = azurerm_resource_group.base.name
  location                 = azurerm_resource_group.base.location
  account_tier             = "Standard"
  account_replication_type = "LRS"

  tags = {
    Name  = "Example Storage Account"
    Owner = "${var.project_name}-tutorial"
  }
}

# Create a Storage Container (Required in Azure)
resource "azurerm_storage_container" "example" {
  name                  = "tutorial-container"
  storage_account_name  = azurerm_storage_account.example.name
  container_access_type = "private"
}

# Upload the Blob (Replaces aws_s3_object)
resource "azurerm_storage_blob" "example" {
  name                   = "README.md"
  storage_account_name   = azurerm_storage_account.example.name
  storage_container_name = azurerm_storage_container.example.name
  type                   = "Block"
  source                 = "./README.md"

  # Azure's equivalent to AWS etag for tracking local file changes
  content_md5 = filemd5("./README.md")
}
