# Copyright (c) HashiCorp, Inc.
# SPDX-License-Identifier: MPL-2.0

# Terraform configuration
import {
  id = "2ee78add8af6d0c88a071fd89b58d50c3f70c9f49272ac3757339d33a870005c"
  to = docker_container.web

}

resource "docker_image" "nginx" {
  name = "nginx:latest"
}
