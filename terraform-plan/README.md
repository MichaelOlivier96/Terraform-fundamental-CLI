# Section 02: Terraform Execution Plan (`terraform-plan`)

## Overview
This section covers how `terraform plan` compares desired state against current state file to preview infrastructure changes safely before execution.

## Key Learnings & Concepts
* **Plan Output:** Evaluates actions to take: `+ create`, `~ update in-place`, or `- destroy`.
* **Predictability & Safety:** `terraform plan` performs read-only operations and does not alter infrastructure.
* **Saving Execution Plans (`-out`):** Using `terraform plan -out "tfplan"` locks proposed changes into a binary file to ensure exact execution during deployment steps.
* **Azure Provider Alignment:** Replaced AWS provider configuration with `azurerm` provider alongside resource group modules and random naming generators.