# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# 1. Network Interfaces (Required in Azure prior to VM creation)
resource "azurerm_network_interface" "app" {
  count               = var.instance_count
  name                = "nic-app-${count.index}"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_ids[count.index % length(var.subnet_ids)]
    private_ip_address_allocation = "Dynamic"
  }

  tags = var.tags
}

# 2. Virtual Machine Instances (Replaces aws_instance)
resource "azurerm_linux_virtual_machine" "app" {
  count               = var.instance_count
  name                = "vm-app-${count.index}"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = "azureuser"

  admin_password                  = "P@ssw0rd1234!"
  disable_password_authentication = false

  network_interface_ids = [
    azurerm_network_interface.app[count.index].id
  ]

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }

  # Azure custom_data requires Base64 encoding
  custom_data = base64encode(<<-EOF
    #!/bin/bash
    apt-get update -y
    apt-get install -y nginx
    systemctl enable nginx
    systemctl start nginx
    echo "<html><body><div>Hello, world from Azure VM!</div></body></html>" > /var/www/html/index.nginx-debian.html
    EOF
  )

  tags = var.tags
}
