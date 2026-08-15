# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "prefix" {
  type        = string
  description = "Prefix for the Azure Resource Group name."
}

variable "location" {
  type        = string
  description = "Azure region location."
  default     = "southafricanorth"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."
  default     = "terraform-plan"
}
