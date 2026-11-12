# Infrastructure ownership and multi-cloud IaC

## Decision
**Do not add Terraform to the default target architecture.** Appendix A explicitly names Pulumi for IaC and Serverless Framework for Lambda functions. It does not say Papaya uses Terraform.

Multi-cloud does not imply one IaC tool must manage every cloud. Pulumi can model resources across providers; provider-specific IAM, networking, service APIs, state and failure modes remain distinct. Preserve one authoritative owner per resource and enforce the same delivery controls across providers.

## Recommended ownership

| Scope | Default owner | Security boundary |
|---|---|---|
| Existing AWS infrastructure | Pulumi | Stack/state-scoped identity and protected update workflow |
| Existing GCP infrastructure | Pulumi where already managed; exact usage to verify | Separate GCP project/service identity and state access |
| Lambda functions and associated Serverless service resources | Serverless Framework / its CloudFormation stack | Dedicated deploy role; protect stack lifecycle and generated template |
| ECS / EC2 application deployment | Existing mechanism — unknown | Discover before proposing replacement |
| k0s cluster infrastructure | Existing platform owner/mechanism — unknown | Separate host/cluster provisioning from workload deployment |
| k0s workloads | Existing deployment mechanism — unknown | Kubernetes RBAC, admission and workload identity |
| Firebase Hosting | Firebase CLI/GitHub deployment integration or existing owner — verify | Separate preview/production projects and deploy identities |
| New Terraform scope | None by default | Only after explicit platform decision and resource ownership boundary |

Serverless Framework translates AWS service configuration into CloudFormation and manages a CloudFormation stack. Treat that stack as a distinct lifecycle; do not let Pulumi or Terraform also reconcile the same stack-owned resources.

## IaC workflow for the stated tools
1. Agent authors Pulumi or Serverless configuration in a branch; it has no production credentials.
2. Local checks run without privileged cloud access where possible.
3. PR CI runs format/lint, static security checks, policy tests and a restricted preview.
4. Preview/state access is limited to target stack/environment and treated as sensitive.
5. CODEOWNERS and a named human review source diff and preview.
6. A protected deployment job obtains a short-lived environment identity after approval.
7. Approved update runs against exact reviewed commit/plan.
8. Post-deployment checks validate resource state, service health, drift and audit events.
9. Recovery uses the IaC engine's supported state/version recovery and a reviewed reconciliation plan; do not blindly restore state.

## Multi-cloud identity
- AWS deployment jobs use GitHub OIDC to assume narrowly scoped IAM roles.
- GCP deployment jobs use GitHub OIDC through Workload Identity Federation to access narrowly scoped service accounts/resources.
- Use separate identities for preview/plan, non-production deployment and production deployment.
- Do not reuse AWS SSO credentials, GCP user credentials or service-account key files in coding-agent sessions.
- k0s workload service accounts are distinct from CI deploy identities; map cloud access explicitly per workload.
- Model inference permissions are separate from infrastructure administration and claim-data access.

## State and secret protection
Pulumi state, secrets providers and deployment artifacts are sensitive. Confirm the actual backend and secrets provider before prescribing exact configuration. Require encrypted state, least-privilege state access, audit, version/recovery and no state export to coding agents. Serverless deployment artifacts and CloudFormation templates must also be protected from untrusted PR access.

## When Terraform would be justified
Terraform may be considered only if Papaya platform owners confirm one of these conditions:
1. Terraform is already an approved organizational standard for some foundations.
2. Platform team explicitly chooses Terraform for new AWS/GCP landing-zone foundations.
3. A funded migration from Pulumi is approved with ownership transfer, state migration, operational training and rollback plan.

If adopted:
- Create separate AWS and GCP roots/states/identities by account/project and environment.
- Pin Terraform/provider/module versions and commit the lock file.
- Protect remote state with encryption, locking, versioning, least-privilege and audit.
- Treat saved plans and state as sensitive artifacts.
- Separate plan and apply identities; production apply remains protected and human-approved.
- Maintain resource ownership inventory and prohibit duplicate Pulumi/Terraform/Serverless management.

Do not use Terraform merely as a cross-cloud abstraction or as a second owner for existing resources.

## Decision matrix

| Option | Fit to source | Operational cost | Decision |
|---|---|---|---|
| Pulumi + Serverless as stated | Direct fit | Lowest change; no new state system | **Default recommendation** |
| Add Terraform for new foundations only | Conditional; not stated as current | Adds third IaC tool and state/security operations | Only after platform-owner decision |
| Migrate all Pulumi to Terraform | Not requested | High migration, state and operational risk | Reject for this challenge |
| Manage same resource in multiple engines | Conflicts with single-owner lifecycle | Drift, replacement and unclear incident ownership | Prohibit |

## References
- [Pulumi providers](https://www.pulumi.com/docs/iac/concepts/resources/providers/)
- [Pulumi state and secrets](https://www.pulumi.com/docs/iac/concepts/state-and-backends/)
- [Serverless Framework AWS deployment](https://www.serverless.com/framework/docs/providers/aws/guide/deploying)
- [Serverless Framework AWS resources](https://www.serverless.com/framework/docs/providers/aws/guide/resources)
- [GitHub Actions OIDC deployment hardening](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments)
- [Google Workload Identity Federation](https://cloud.google.com/iam/docs/workload-identity-federation)
