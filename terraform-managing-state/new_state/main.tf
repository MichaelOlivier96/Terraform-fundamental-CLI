provider "azurerm" {
  features {}
}

data "terraform_remote_state" "root" {
  backend = "local"

  config = {
    path = "../terraform.tfstate"
  }
}

# Fetch the networking backbone created in the root directory
data "azurerm_resource_group" "existing" {
  name = "terraform-learn-state-rg"
}

data "azurerm_subnet" "existing" {
  name                 = "internal"
  virtual_network_name = "terraform-learn-state-vnet"
  resource_group_name  = data.azurerm_resource_group.existing.name
}

resource "azurerm_public_ip" "example_new" {
  name                = "terraform-learn-state-pip-new"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "example_new" {
  name                = "terraform-learn-state-nic-new"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.existing.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.example_new.id
  }
}

# Dynamically apply the Network Security Group ID retrieved from the root state
resource "azurerm_network_interface_security_group_association" "example_new" {
  network_interface_id      = azurerm_network_interface.example_new.id
  network_security_group_id = data.terraform_remote_state.root.outputs.security_group
}

resource "azurerm_linux_virtual_machine" "example_new" {
  name                = "terraform-learn-state-vm-new"
  location            = data.azurerm_resource_group.existing.location
  resource_group_name = data.azurerm_resource_group.existing.name
  size                = "Standard_D2s_v5"
  admin_username      = "azureuser"
  network_interface_ids = [
    azurerm_network_interface.example_new.id,
  ]

  admin_ssh_key {
    username   = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-focal"
    sku       = "20_04-lts-gen2"
    version   = "latest"
  }

  custom_data = base64encode(<<-EOF
              #!/bin/bash
              apt-get update
              apt-get install -y apache2
              sed -i -e 's/80/8080/' /etc/apache2/ports.conf
              echo "Hello World" > /var/www/html/index.html
              systemctl restart apache2
              EOF
  )
}
