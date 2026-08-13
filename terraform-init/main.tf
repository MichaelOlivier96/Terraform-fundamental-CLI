# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

provider "azurerm" {
  features {}
}

provider "random" {}

resource "random_pet" "instance" {
  length = 2
}

module "azure_vm" {
  source = "./modules/azure-virtual-machine"

  prefix   = "${var.project_name}-${random_pet.instance.id}"
  location = var.location
}

module "hello" {
  source  = "joatmon08/hello/random"
  version = "6.0.0"

  hellos = {
    hello        = random_pet.instance.id
    second_hello = "World"
  }

  some_key = "secret"
}
