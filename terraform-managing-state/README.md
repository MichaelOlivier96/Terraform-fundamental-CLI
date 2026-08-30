# Section 09:Managing Infrastructure State with Terraform CLI (`terraform-managing-state`)

## Overview
The hands-on implementation of the HashiCorp Terraform tutorial **"Manage resources in Terraform state"**, converted from AWS to **Microsoft Azure** syntax.

The primary objective of this module is to understand how Terraform tracks infrastructure using its state file (`terraform.tfstate`) and how to safely inspect, move, decouple, and replace cloud resources outside of standard `plan` and `apply` workflow cycles.

---

## Core Principles & Takeaways Learned

### 1. Multi-Resource State Dependency in Azure
* Unlike AWS, where an `aws_instance` encapsulates networking implicitly, Azure requires explicit resource declarations (`azurerm_resource_group`, `azurerm_virtual_network`, `azurerm_subnet`, `azurerm_public_ip`, `azurerm_network_interface`, `azurerm_network_security_group`, and `azurerm_linux_virtual_machine`).
* When performing state operations like `terraform state mv` or `terraform state rm`, all dependent child resources (VM, vNIC, Public IP, NSG Association) must be managed together to prevent orphaned state objects.

### 2. Safe State Operations (`list`, `show`, `mv`, `rm`, `-replace`)
* **State Inspection:** `terraform state list` outlines managed address paths, while `terraform state show <RESOURCE>` inspects specific attributes without requiring API drift queries.
* **Refactoring Infrastructure:** `terraform state mv` re-binds resources to new module/file targets (e.g., transferring resources to the `new_state/` project) without causing cloud teardown or downtime.
* **Untracking Resources:** `terraform state rm` removes state management from cloud infrastructure while leaving real-world resources running in Azure.
* **Targeted Recreation:** `terraform apply -replace="<RESOURCE_ADDRESS>"` forces destruction and re-provisioning of a specific degraded resource without disrupting the rest of the stack.

---