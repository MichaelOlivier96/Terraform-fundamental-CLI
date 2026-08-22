# Section 06: Managing Terraform & Provider Versions (`terraform-versions`)

## Overview
This section explores how to lock and manage versions for the Terraform CLI and infrastructure providers using pessimistic constraint operators (`~>`). It also captures key hands-on takeaways from converting single-instance AWS configurations into explicit Azure architecture, troubleshooting real-world cloud errors, and enforcing credential security best practices.

## Key Concepts & Technical Learnings

### 1. Version Constraints & Mechanics
* **Pessimistic Constraint Operator (`~>`):** Restricts updates to safe patch levels.

### 2. AWS to Azure Architecture & Networking
* **Explicit Resource Hierarchy:** AWS `aws_instance` resources leverage implicit default VPCs. Azure requires an explicit stack: 
Resource Group-Virtual Network-Subnet-Public IP-Network Interface Card (NIC)-Virtual Machine.
* **NIC `ip_configuration` Block:** Acts as the network bridge by assigning private IP allocation (`Dynamic`), linking to a specific subnet, and binding an internet-facing Public IP to the VM adapter.
* **Public IP SKU Enforcement:** Azure enforces `sku = "Standard"` for new public IP allocations..

### 3. Cloud Capacity & Troubleshooting
* **Handling `SkuNotAvailable` Errors:** Physical hardware constraints can cause specific VM sizes (like `Standard_B1s`) to run out of capacity in high-demand regions. 
* **Resolution Strategies:** Resolve capacity blocks by changing regions and/or stepping up to an available VM SKU (`Standard_B2s`).

### 4. Credential Security & Production Standards
* **Hardcoded Credentials:** Storing `admin_username` or `admin_password` in `.tf` files risks exposing secrets in source control.
* **SSH Key Authentication:** Enforce `disable_password_authentication = true` and provide public keys via the `admin_ssh_key` block.
* **Enterprise Access:** Production deployments manage VM access dynamically through Microsoft Entra ID (Azure AD) RBAC, Azure Key Vault, or short-lived CI/CD pipeline secrets.

### 5. Included Utility Scripts
* **`init-script.sh`:** A boot-time initialization script translated from RHEL/Yum syntax to Debian/Apt syntax to auto-install Apache, PHP, and web dependencies.
* **`workspace_versions.sh`:** A standalone shell script that uses `curl` and `jq` to query the Terraform Cloud API for workspace version reports.