# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

variable "location" {
  type        = string
  description = "Azure region for all resources."

  default = "southafricanorth"
}

variable "project_name" {
  type        = string
  description = "Name of the example project."

  default = "terraform-plan"
}

variable "secret_key" {
  type        = string
  sensitive   = true
  description = "Secret key for hello module"
}
