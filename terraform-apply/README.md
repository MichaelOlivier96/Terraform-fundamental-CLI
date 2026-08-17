# Section 03: Terraform Apply & State Drift Troubleshooting (`terraform-apply`)

## Overview
This section covers executing infrastructure changes with `terraform apply`, managing multi-resource dependencies, and troubleshooting state discrepancies caused by manual changes or missing local file dependencies.

## AWS to Azure Provider Adaptations

## Key Takeaways
* **Reconciliation:** `terraform apply` acts as a self-healing tool that forces real-world infrastructure back into alignment with your declared HCL configuration.
* **Execution Safety:** Using `-out=tfplan` locks execution parameters, but local file dependencies referenced by resources like `azurerm_storage_blob` must remain available at execution time.