# Section 05: Querying Infrastructure with Outputs (`terraform-outputs`)

## Overview
This section demonstrates how to define, manage, and query output values from Terraform configurations and local modules, with a specific focus on handling sensitive data securely.

## Key Learnings & Concepts
* **Exposing Infrastructure Data:** Used `outputs.tf` to export dynamically generated attributes, such as Load Balancer FQDNs and Virtual Network IDs.
* **Sensitive Outputs (`sensitive = true`):** Redacted database administrative credentials from terminal output to prevent secret exposure in execution logs.
* **Command-Line Extraction:** Exercised `terraform output` for manual inspection and `terraform output -raw <name>` for script automation.

## Azure Provider Adaptations
* Replaced AWS VPC/Security Group/S3 modules with native `azurerm_virtual_network`, `azurerm_subnet`, and `azurerm_lb` resources.
* Replaced Amazon RDS MySQL with `azurerm_mysql_flexible_server` using a dedicated delegated subnet (`Microsoft.DBforMySQL/flexibleServers`).
* Converted local compute module to deploy Azure Linux Virtual Machines with `custom_data` web server initialization.