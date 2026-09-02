# Section 11: Terraform State Management: Syncing State with `-refresh-only` flag (`terraform-refresh`)

This repository contains an Azure-adapted implementation of HashiCorp's official Terraform CLI tutorial on state synchronization and drift management.

---

## Core Learning Objectives

1. **Understand State Drift**  
   Infrastructure drift occurs when actual cloud resources diverge from what is tracked in the `terraform.tfstate` file (e.g., via manual Azure Portal edits, external CLI scripts, or provider scope changes).

2. **Legacy `terraform refresh` vs. Modern `-refresh-only`**  
   - **Legacy (`terraform refresh`)**: Overwrites the state file directly without displaying a plan or asking for interactive approval. If provider scopes or region variables are misconfigured, it can silently purge resources from state. *(Deprecated)*
   - **Modern (`terraform plan/apply -refresh-only`)**: A safe, two-phase synchronization workflow that generates a clear execution plan showing proposed state updates before modifying the state file.

3. **In-Memory vs. Persistent State Sync**  
   - Standard `terraform plan` and `terraform apply` execute an **implicit in-memory refresh** to align state with reality when constructing execution plans.
   - `-refresh-only` mode allows updating the **persistent state file** and workspace `outputs` without altering live cloud resources.

---
