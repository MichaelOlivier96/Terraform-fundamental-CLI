# Section 12: Migrate State to Terraform Cloud (`terraform-migrate-state`)

### Overview:

Explains the transition from single-user local state management (terraform.tfstate) to centralized cloud backends using HCP Terraform (formerly Terraform Cloud).

### Core Lessons Extracted:

Declarative cloud Block Syntax: Utilizing terraform { cloud { ... } } (Terraform v1.1+) instead of legacy backend "remote".

Zero-Downtime Migration: How terraform init detects state backend changes and copies existing resource state without destroying active infrastructure.

Version Alignment Safety: Protecting state schema integrity by matching local CLI versions with workspace configurations.

State Security & Locking: Encrypting state at rest and securing concurrency via automatic state locking.

### Real-World Engineering Use Cases:

PoC to Production: Handing off local infrastructure prototypes to operations teams.

Multi-Developer Collaboration: Preventing race conditions with state locks.

CI/CD Integration: Running speculative plans on pull requests via OIDC / API tokens.

Governance & Audit: Keeping full historical state versioning for compliance (SOC2 / ISO 27001).