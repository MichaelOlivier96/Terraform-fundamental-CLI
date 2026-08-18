# Section 04: Terraform Input Variables & Types (`terraform-variables`)

## Overview
In this tutorial, I added variables to my configuration to make it easier to modify over its lifecycle. Variables also make it easier to re-use configuration for other projects, or turn it into a module. 

It can also make the configuration more generic, by saving project-specific configuration in the variables file. 

Outputs—translated from AWS to Azure.

## Key Concepts & Variable Types
* **Strings & Numbers:** Parametrized settings like `location` (`string`) and `instance_count` (`number`) to keep code flexible.
* **Booleans:** Applied toggle parameters such as `enable_vpn_gateway` (`bool`)for feature flags.
* **Lists & Maps:** Structured collections like CIDR block lists (`list(string)`) and resource tags (`map(string)`).
* **Custom Validation Blocks:** Enforced strict naming length and formatting rules using regular expressions on tag inputs.
* **Unset Input Variables:** Leveraged `vm_size` without a default value to practice terminal prompts, `-var` CLI flags, and `terraform.tfvars` auto-loading.