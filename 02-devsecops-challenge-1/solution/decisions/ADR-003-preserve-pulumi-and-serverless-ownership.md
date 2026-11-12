# ADR-003: Preserve Pulumi and Serverless Framework as IaC owners

- Status: Proposed
- Decision owner: Platform/IaC owner
- Date: 2026-11-12

## Context
The employer scenario identifies Pulumi for infrastructure as code and Serverless Framework for Lambda services. Terraform is not identified as a current owner.

## Decision
Keep each existing resource under its current Pulumi stack or Serverless/CloudFormation lifecycle. Use previews, policy checks and protected apply/deploy identities. Do not introduce Terraform or allow two engines to manage the same resource. Terraform may be evaluated only for a separately scoped new estate with explicit ownership and a migration decision.

## Consequences and verification
Avoids state migration, drift and competing ownership. Multi-cloud controls use separate provider identities and stack boundaries, not an IaC replacement. Inventory ownership, reject duplicate declarations and verify preview/apply identities are separate.

## Alternatives rejected
Blanket Terraform migration, dual management of one resource, and one undifferentiated multi-cloud state.
