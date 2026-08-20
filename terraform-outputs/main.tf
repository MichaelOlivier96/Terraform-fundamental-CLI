# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

resource "random_string" "suffix" {
  length  = 4
  special = false
  upper   = false
}

# 1. Base Networking
resource "azurerm_resource_group" "main" {
  name     = "rg-outputs-tutorial"
  location = var.location
}

resource "azurerm_virtual_network" "main" {
  name                = "vnet-outputs"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  address_space       = [var.vnet_address_space]
}

resource "azurerm_subnet" "private" {
  count                = length(var.private_subnet_cidr_blocks)
  name                 = "private-subnet-${count.index}"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = [var.private_subnet_cidr_blocks[count.index]]
}

# 2. Database Dedicated Subnet & MySQL Server
resource "azurerm_subnet" "database" {
  name                 = "database-subnet"
  resource_group_name  = azurerm_resource_group.main.name
  virtual_network_name = azurerm_virtual_network.main.name
  address_prefixes     = ["10.0.200.0/24"]

  delegation {
    name = "fs"
    service_delegation {
      name    = "Microsoft.DBforMySQL/flexibleServers"
      actions = ["Microsoft.Network/virtualNetworks/subnets/join/action"]
    }
  }
}

resource "azurerm_mysql_flexible_server" "database" {
  name                   = "mysql-db-${random_string.suffix.result}"
  resource_group_name    = azurerm_resource_group.main.name
  location               = azurerm_resource_group.main.location
  administrator_login    = var.db_username
  administrator_password = var.db_password
  sku_name               = "B_Standard_B1s"
  delegated_subnet_id    = azurerm_subnet.database.id
}

# 3. Load Balancer & Public IP
resource "azurerm_public_ip" "lb_pip" {
  name                = "pip-lb"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name
  allocation_method   = "Static"
  domain_name_label   = "lb-outputs-${random_string.suffix.result}"
}

resource "azurerm_lb" "main" {
  name                = "lb-outputs"
  location            = azurerm_resource_group.main.location
  resource_group_name = azurerm_resource_group.main.name

  frontend_ip_configuration {
    name                 = "PublicIPAddress"
    public_ip_address_id = azurerm_public_ip.lb_pip.id
  }
}

# 4. Compute Module
module "vm_instances" {
  source = "./modules/azure-instance"

  instance_count      = var.instances_per_subnet * length(azurerm_subnet.private)
  vm_size             = var.vm_size
  subnet_ids          = azurerm_subnet.private[*].id
  resource_group_name = azurerm_resource_group.main.name
  location            = azurerm_resource_group.main.location
}
