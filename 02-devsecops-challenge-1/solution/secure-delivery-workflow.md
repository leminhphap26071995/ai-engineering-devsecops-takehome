# Secure delivery and production change workflow

## End-to-end path

~~~mermaid
flowchart TD
  TASK["Task contract: outcome, scope, risk, acceptance"] --> DISCOVER["Discover source, dependencies, ownership and baseline"]
  DISCOVER --> DESIGN["Threat/failure analysis + option trade-offs"]
  DESIGN --> CHANGE["Scoped implementation in isolated workspace"]
  CHANGE --> VERIFY["Functional + security + performance + resilience checks"]
  VERIFY --> ACCEPT{"Evidence meets acceptance?"}
  ACCEPT -->|No| REPAIR["Diagnose and repair from observed evidence"]
  REPAIR --> CHANGE
  ACCEPT -->|Yes| PR["Immutable source revision + PR"]
  PR --> CI["Untrusted validation: no production secrets"]
  CI --> CHECKS["Tests, SAST/SCA, secrets, IaC, image and policy checks"]
  CHECKS --> REVIEW["Named human reviews exact diff and evidence"]
  REVIEW --> PROD{"Production change?"}
  PROD -->|No| MERGE["Protected merge"]
  PROD -->|Yes| ENV["Protected environment + named approval"]
  ENV --> ID["Short-lived AWS OIDC / GCP WIF identity"]
  ID --> DEPLOY["Deploy exact reviewed artifact / plan"]
  MERGE --> OBS["Health, security, performance and audit signals"]
  DEPLOY --> OBS
  OBS --> RECOVER["Rollback / failover / restore / incident response"]
~~~

## Monorepo pipeline design
The employer states one monorepo for applications, web, backend, mobile, AI/ML and IaC. Exact paths and dependency graph are unknown. Discover them before authoring path filters.

1. Determine changed paths and affected dependency graph, including shared packages, generated clients, build tooling and base images.
2. Run component tests/builds for affected services.
3. Always run repository-wide secret scanning and checks for security-critical paths: workflows, IaC, IAM, identity, deployment policy and shared authorization.
4. Prevent path filters from skipping downstream services affected by shared code.
5. Protect infrastructure, IAM, workflow, tool catalogue and security policy paths with CODEOWNERS and required reviews.
6. Separate untrusted PR validation from privileged release/deploy workflows.
7. Publish immutable artifacts with source SHA, digest and provenance; promote the same tested artifact where practical.

## Required CI checks
Select checks based on actual stack and change impact:
- unit/integration/contract tests and builds for affected Node.js/TypeScript, GraphQL, PostgreSQL, Next.js/React, React Native/Expo and Python/PyTorch components;
- SAST, SCA/license and secret scanning;
- container/image and Kubernetes manifest security;
- Pulumi preview/policy and Serverless/CloudFormation validation;
- workflow permission and action supply-chain checks;
- SBOM, artifact provenance and signature verification where supported;
- performance smoke/load tests for performance-sensitive changes;
- migration, rollback and compatibility tests for stateful changes.

Do not run every expensive test on every commit. Use fast local feedback, focused PR checks and scheduled/full regression suites while preserving always-on critical security checks.

## GitHub Actions credential model
- Inventory, revoke/rotate existing long-lived GitHub tokens and AWS keys in repository secrets.
- Use minimum `GITHUB_TOKEN` permissions per workflow/job.
- Pin third-party actions to reviewed immutable commit SHAs.
- Separate untrusted PR validation from privileged release/deploy workflows; do not grant ordinary PR jobs production secrets or cloud federation permissions.
- Grant `id-token: write` only to the job that requests cloud federation; cloud authorization still comes from trust policy and IAM.
- Use dedicated identities for validation/preview, non-production deployment and production deployment.
- Protect reusable workflows, workflow files, caches and artifact promotion paths.

## Cloud and IaC deployment
- AWS OIDC: restrict trust to expected repository, ref/workflow and protected environment; verify token claims and resulting role permissions.
- GCP WIF: restrict provider attributes to expected repository/workflow/ref/environment and grant resource-level least privilege.
- Pulumi: preview and policy evaluation on PR; protected update with appropriate environment identity. Protect state and secrets.
- Serverless Framework: validate generated CloudFormation and deploy the owned stack through a protected job.
- ECS/EC2, k0s cluster provisioning and Firebase deployment mechanisms are not specified; discover existing owners and workflows before implementation.
- Firebase preview channels must use isolated backends and synthetic data; a preview URL alone does not isolate backend resources.

## Production approval contract
Every production change requires a named human reviewer/approver, whether initiated by an agent or a person. Bind approval to:
- exact PR and commit SHA;
- relevant functional/security/performance results;
- exact IaC preview/plan or immutable artifact digest;
- target environment and deployment identity;
- approver identity and timestamp.

Any material change to the commit, artifact, plan or environment invalidates approval. The agent cannot approve its own change or alter the policy authorizing deployment.

## Performance and operational gates
- Record baseline and target for relevant p95/p99 latency, throughput, errors, saturation, queue age and cost.
- Set load-test thresholds from service SLO and known workload; never invent universal numbers.
- Observe rollout health and stop/rollback on agreed error-budget or service-health guardrails.
- Bound retries and concurrency; require idempotency for replayable operations.
- Define rollback/roll-forward, backup restore and failover ownership before production release.
- A green CI run is not proof of production readiness or successful recovery.

## IaC ownership
- Pulumi remains authoritative for resources already managed by Pulumi.
- Serverless Framework owns its service/CloudFormation lifecycle.
- Each resource/stack has one authoritative reconciler.
- Do not add Terraform or transfer ownership without an explicit platform decision, state migration and rollback plan.
