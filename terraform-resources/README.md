# Section 08: Terraform Target Resources (terraform-resources)

## Key Takeaways
* **Target Flag Syntax**: Use `-target=<RESOURCE_ADDRESS>` to apply updates to a single resource or subset of resources.
  * Example targeting a specific blob: `terraform apply -target=azurerm_storage_blob.objects[0]`
* **Use Cases**: Use targeting strictly for exceptional recovery scenarios, breaking dependency cycles, or emergency updates.
* **Risks**: Avoid routine targeting as it can create state drift and unintended dependency omissions, and why HashiCorp recommends using it primarily for exceptional fix scenarios rather than routine workflows.