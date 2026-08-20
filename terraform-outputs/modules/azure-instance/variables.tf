# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "instance_count" {
  description = "Number of VMs to deploy"
  type        = number
}

variable "vm_size" {
  description = "Size of Azure Virtual Machine"
  type        = string
}

variable "subnet_ids" {
  description = "Subnet IDs for VM network interfaces"
  type        = list(string)
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "location" {
  description = "Azure region location"
  type        = string
}
