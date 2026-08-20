# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "location" {
  description = "Azure region location"
  type        = string
  default     = "eastus"
}

variable "vnet_address_space" {
  description = "CIDR block for VNet"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidr_blocks" {
  description = "Available cidr blocks for public subnets"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnet_cidr_blocks" {
  description = "Available cidr blocks for private subnets"
  type        = list(string)
  default     = ["10.0.101.0/24", "10.0.102.0/24"]
}

variable "instances_per_subnet" {
  description = "Number of VMs per private subnet"
  type        = number
  default     = 2
}

variable "vm_size" {
  description = "Size for Virtual Machines"
  type        = string
  default     = "Standard_B1s"
}

# Warning: Never check sensitive values like usernames and passwords into source control. 
# Tutorial purposes only, rather keep in .tfvar file.
variable "db_username" {
  description = "Database administrator username."
  type        = string
  default     = "adminuser"
}

variable "db_password" {
  description = "Database administrator password."
  type        = string
  default     = "NotASecureP@ssw0rd!"
}
