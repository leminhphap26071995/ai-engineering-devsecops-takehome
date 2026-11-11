# 5. Monorepo CI/CD and Production Change Workflow

## End-to-end workflow

~~~mermaid
flowchart TD
  TASK["Approved task, owner, risk and acceptance"] --> AGENT["Claude Code in isolated dev workspace"]
  AGENT --> LOCAL["Local tests, lint, build and IaC preview"]
  LOCAL --> BRANCH["Feature branch + PR in GitHub monorepo"]
  BRANCH --> SCOPE["Determine changed components and dependency impact"]
  SCOPE --> CI["Untrusted PR validation: no production secrets"]
  CI --> SEC["Tests, SAST, SCA, secrets, IaC, image and policy checks"]
  SEC --> REVIEW["Named human reviews diff, checks and plan"]
  REVIEW --> APPROVE{"Production change?"}
  APPROVE -->|No| MERGE["Protected merge"]
  APPROVE -->|Yes| ENV["Protected environment: named approval"]
  ENV --> ID["Short-lived AWS OIDC / GCP WIF identity"]
  ID --> DEPLOY["Deploy exact reviewed commit/artifact/plan"]
  DEPLOY --> VERIFY["Health, security and smoke verification"]
  VERIFY --> OBS["Audit, monitoring and rollback readiness"]
  MERGE --> OBS
~~~

## Monorepo pipeline design
The employer states one monorepo for apps, web, backend, mobile, AI/ML and IaC. Exact paths/dependency graph are unknown, so the pipeline should be path- and dependency-aware rather than assume a specific layout.

1. Determine changed paths and affected dependency graph, including shared packages, generated clients, build tooling and common security configuration.
2. Run relevant component tests/builds for affected services.
3. Always run repository-wide secret scanning and checks for security-critical paths such as workflows, IaC, policy, identity and deployment configuration.
4. Do not let path filters skip a downstream service when a shared library or base image changes.
5. Use CODEOWNERS and required reviews for infrastructure, IAM, workflow, plugin marketplace and security policy paths.
6. Keep untrusted PR validation separate from privileged release/deploy jobs; never expose production secrets or cloud id-token permission to fork/untrusted code.
7. Publish immutable artifacts with source SHA, digest and provenance; promote the same artifact through environments where practical.

## Required CI checks
- Node.js/TypeScript backend tests, GraphQL schema/contract and resolver authorization tests, PostgreSQL migration/integration tests, Next.js/React web tests, React Native/Expo build checks, and Python/PyTorch AI/ML tests appropriate to affected components.
- SAST and dependency/SCA/license checks.
- Secret scanning and prevention of credential regressions.
- Container/image and Kubernetes manifest security checks for affected workloads.
- Pulumi preview/policy checks and Serverless/CloudFormation template checks for infrastructure changes.
- Workflow permission and action supply-chain review; pin third-party actions to immutable commit SHAs.
- SBOM/provenance/signature verification where supported by the existing build pipeline.
- No secrets in PR logs, artifacts, build caches or test fixtures.

## GitHub Actions credential remediation
- Inventory and revoke/rotate existing long-lived GitHub tokens and AWS access keys in repository secrets; remove workflow references and historical artifacts as appropriate.
- Prefer built-in GITHUB_TOKEN with minimum per-workflow/job permissions. Use a GitHub App with narrowly scoped installation permissions only where cross-repository/elevated API access is genuinely needed.
- Grant id-token: write only to the deployment job requiring federation; not ordinary PR validation.
- AWS: GitHub OIDC → dedicated IAM role with trust conditions for expected repository, branch/tag, workflow and protected environment.
- GCP: GitHub OIDC → Workload Identity Federation → narrowly scoped service account/resource permissions.
- Separate validation/preview, non-production deploy and production deploy identities.
- Restrict reusable workflows, protect workflow files and require review for trust-policy changes.

## AWS deployment path
- Lambda services remain deployed through Serverless Framework and its CloudFormation stack lifecycle.
- Pulumi-managed infrastructure remains under Pulumi state and update workflows.
- ECS/EC2 deployment mechanism is not specified in the challenge and must be confirmed before implementation.
- Aurora, S3, SNS/SQS and Step Functions access is granted to workload identities for the specific service/function, not the coding agent.
- Production deployment credentials are minted only inside the protected job after approval.

## GCP and Firebase deployment path
- GCP model/application workloads use distinct workload identities for Vertex AI/Gemini inference, data access and infrastructure administration.
- Firebase Hosting preview and production deploys use separate projects or equivalent isolated resources and credentials.
- Firebase PR preview channels are useful for review, but Google's documentation warns preview URLs interact with the real backend resources of the Firebase project. Do not point untrusted PR previews at production data/services; use a dedicated preview backend and synthetic data.
- Review the default Firebase GitHub integration carefully: its setup flow creates a service-account JSON key and stores it as a GitHub secret. Prefer keyless federation where the chosen deploy workflow supports it; otherwise tightly scope and rotate the credential.

## Production approval contract
Every production change — human- or agent-originated — must have a named human who reviewed and approved it, as required by the scenario.

Bind approval to:
- exact PR and commit SHA;
- relevant test/security results;
- exact IaC preview/plan or immutable artifact digest;
- target environment and deployment identity;
- approver identity and timestamp.

A changed commit invalidates prior approval and requires review again. The agent cannot approve its own change or modify policy authorizing deployment.

A second approver for high-risk IAM, network, data and security-policy changes is recommended separation of duties, not an explicit baseline requirement.

## IaC deployment path
- Pulumi: preview and policy evaluation on PR; protected update after approval using the appropriate environment identity.
- Serverless Framework: validate generated CloudFormation and deployment permissions; deploy its stack through a protected job.
- Terraform is not part of the default pipeline because the scenario does not state it is used. If later adopted, use a separate state/identity lane and the rules in [IaC strategy](10-MULTICLOUD-IAC-STRATEGY.md).

## Rollback and verification
Deploy immutable artifacts; verify service health, error rate, security signals and data-path behavior after deployment. Rollback uses the established service/IaC recovery procedure and must be auditable. Do not blindly restore IaC state without reconciling actual cloud resources.
