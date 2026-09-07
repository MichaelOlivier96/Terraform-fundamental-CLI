# Infrastructure as Code (IaC) Competencies: HashiCorp Terraform CLI

## Overview
This repository documents the practical completion and technical adaptation of HashiCorp's **Terraform CLI Track**. While the core curriculum models AWS infrastructure patterns, all hands-on exercises—excluding dedicated Docker container workflows—were systematically re-architected and deployed against **Microsoft Azure**. 

This hands-on work demonstrates end-to-end proficiency in managing infrastructure lifecycles, adapting multi-cloud resource definitions, governing state integrity, and maintaining enterprise security baselines.

---

## Core Competencies Demonstrated

### 1. Cross-Cloud Infrastructure Architecture & Adaptation
* **AWS-to-Azure Refactoring:** Translated AWS infrastructure primitives (EC2, VPCs, Security Groups, S3) into native Microsoft Azure architectural patterns (Azure Virtual Machines, VNets, Network Security Groups, and Blob Storage).
* **Containerized Workflows:** Provisioned and managed local containerized runtimes using the Docker provider to isolate environment dependencies during lifecycle testing.

### 2. Execution Plan Mechanics & Lifecycle Governance
* **Deterministic Deployment:** Controlled deployment risks using speculative execution plans (`terraform plan -out`), ensuring immutable plan execution across heterogeneous environments.
* **Granular Blast-Radius Control:** Executed targeted deployments (`-target`) across modules and independent resource collections to execute zero-downtime micro-updates.

### 3. State Management & Drift Reconciliation
* **Drift Detection & Alignment:** Synchronized real-world cloud resources with internal state topologies using `refresh-only` operations without introducing unintended side effects.
* **State Refactoring & Onboarding:** Performed non-destructive state manipulation (`terraform state mv`, `rm`) and onboarded unmanaged infrastructure into Terraform state using native `import` block generation.

### 4. Enterprise Security & Supply Chain Hygiene
* **Provider & Version Locking:** Enforced strict binary versioning (`required_version`) and maintained dependency lock files (`.terraform.lock.hcl`) to guarantee deterministic build outputs across team operations.
* **Secrets & Output Redaction:** Parameterized infrastructure configurations using dynamic inputs while enforcing strict redaction policies on sensitive output values.

---

## Architectural Impact & Value
By converting standardized curriculum patterns into Azure-native configurations, this project demonstrates direct agility in:
* Reading, interpreting, and refactoring third-party Infrastructure as Code (IaC).
* Managing complex infrastructure lifecycles from zero-state provisioning to drift correction and migration.
* Bridging cloud-native resource models while adhering to HashiCorp best practices for security and governance.
