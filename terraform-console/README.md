# Section 15: Terraform Console Command (`terraform-console`)

### Overview
Terraform console can be used to explore your state and evaluate Terraform expressions before using them in your configuration. The Terraform console can help you develop and troubleshoot your Terraform configurations.

### Architecture & Syntax Translation (AWS → Azure):
Resource Hierarchy: Details the shift from global AWS S3 buckets to Azure's 3-tier hierarchy (azurerm_resource_group → azurerm_storage_account → azurerm_storage_container).

Naming Rules & Constraints: Highlights Azure Storage Account constraints (lowercase alphanumeric only, no hyphens) and the integration of random_string.

Scope & Access Control: Documents the shift from AWS bucket policies to Azure RBAC (azurerm_role_assignment) using resource_manager_id and azurerm_client_config.

### Practical terraform console Workflows (Tasks A–E):

Task A: JSON policy rendering and string interpolation (jsonencode).

Task B: Subnet calculation and CIDR math (cidrsubnet()).

Task C: Collection/map transformations using HCL for expressions.

Task D: Non-destructive state inspection and attribute discovery (keys(), primary_blob_endpoint).

Task E: Testing identity retrieval (object_id) and scope paths for Azure Role Assignments.
