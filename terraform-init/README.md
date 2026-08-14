# Section 01: Terraform CLI Initialization (`terraform-init`)

## Overview
This section demonstrates how `terraform init` prepares a working directory by initializing local backends, downloading provider binaries, and fetching local/remote modules.

## Key Concepts & Adaptation
* **Provider Configuration:** Adapted HashiCorp's AWS-focused setup to use the **`azurerm`** provider with required Service Principal authentication (`ARM_*` environment variables).
* **`terraform init` Workflow:** 
  1. Downloads required provider binaries (`azurerm`, `random`).
  2. Resolves local path modules (`./modules/azure-virtual-machine`).
  3. Downloads remote registry modules (`joatmon08/hello/random`) into `.terraform/modules/`.
* **Dependency Lock File:** Generates `.terraform.lock.hcl` to lock provider versions for consistent executions.

## Directory Structure
* `terraform.tf` — Provider declarations and version constraints.
* `variables.tf` — Input variables (`location`, `project_name`).
* `main.tf` — Root configuration calling local and remote modules.
* `modules/azure-virtual-machine/` — Local module provisioning an Azure Resource Group (`azurerm_resource_group`).