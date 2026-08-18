# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

provider "random" {}

resource "azurerm_resource_group" "main" {
  name     = "rg-${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
  location = var.location

  tags = var.resource_tags
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.vnet_address_space]

  tags = var.resource_tags
}

resource "azurerm_subnet" "public" {
  count                = var.public_subnet_count
  name                 = "public-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)[count.index]]
}

resource "azurerm_subnet" "private" {
  count                = var.private_subnet_count
  name                 = "private-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [slice(var.private_subnet_cidr_blocks, 0, var.private_subnet_count)[count.index]]
}

resource "azurerm_public_ip" "lb_pip" {
  name                = "pip-lb-${var.resource_tags["project"]}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  domain_name_label   = "lb-${var.resource_tags["project"]}-${var.resource_tags["environment"]}"

  tags = var.resource_tags
}

resource "azurerm_lb" "main" {
  name                = "lb-${var.resource_tags["project"]}-${var.resource_tags["environment"]}"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }

  tags = var.resource_tags
}

module "vm_instances" {
  source = "./modules/azure-instance"

  instance_count      = var.instance_count
  vm_size             = var.vm_size
  subnet_ids          = azurerm_subnet.private[*].id
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
  tags                = var.resource_tags
}
