# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Variable declarations

variable "location" {
  description = "Azure region to deploy resources"
  type        = string
  default     = "southafricanorth"
}
