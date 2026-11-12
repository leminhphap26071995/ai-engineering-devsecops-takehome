# Proposal — AI-assisted DevSecOps engineering with enforceable boundaries

## Executive recommendation
Papaya should let engineers use coding agents throughout the software-delivery lifecycle, while keeping engineering accountability, production authorization and operational control independent of the model.

The working model is:

> **Engineers own outcomes. Coding agents accelerate discovery, design, implementation and verification. Deterministic controls enforce identity and policy. Protected delivery systems release reviewed artifacts. Operations prove service health and recovery.**

The goal is not to make coding agents difficult to use. Engineers should be able to move quickly on ordinary work, while access to production, sensitive data and costly operations stays under controls the agent cannot bypass.

The employer brief names Claude Code Team Premium in its scenario. This remains a fact about Papaya's target environment. The candidate uses Codex as the authoring client for this assessment; candidate-side `.codex/` files do not configure Papaya's developer fleet or production controls. The engineering workflow and enforcement architecture are expressed independently of one vendor's prompt syntax.

This is a reference design based only on the written challenge. Papaya explicitly provides no system access and does not expect it. This is not an implementation, audit, legal opinion or compliance certification.

## 1. Problem and root cause
The scenario combines developer agents with broad ambient authority:
- developer workstations have AWS SSO profiles that can reach production;
- some engineers disable permission prompts;
- MCP servers/plugins are installed ad hoc;
- GitHub Actions contains long-lived tokens and AWS keys;
- monitoring is fragmented and on-call is informal;
- production AI workloads process claim/document/FWA data across insurer tenants and countries;
- every production change requires a named human reviewer/approver.

The root cause is **ambient authority**: the process performing development work can inherit identities and capabilities that are broader than the task requires. Prompt discipline and confirmation dialogs cannot independently constrain direct filesystem, network, API or cloud access.

There are two separate AI trust domains:
1. **Developer coding agents:** source, tests, Git, infrastructure proposals and development tools.
2. **Production AI workloads:** claim assessment, document processing and fraud/waste/abuse workflows, including untrusted uploads, tenant data and application actions.

They must not share credentials, unrestricted tools or trust assumptions.

## 2. How engineering and coding agents work together

### Engineering plane
Owns infrastructure, cloud services, application architecture, CI/CD, identity, security, performance, availability, HA/DR, observability, incident response, recovery and cost.

### Coding-agent support
Helps engineers understand systems, retrieve relevant context, compare designs, author scoped changes, automate deterministic work, analyze failures and produce evidence. It does not approve production changes or grant itself permissions.

The detailed task lifecycle and expected agent behavior are in [AI-assisted DevSecOps workflow](ai-assisted-devsecops-workflow.md).

## 3. Target reference architecture

~~~mermaid
flowchart TB
  subgraph HUMAN["Engineering accountability"]
    OWNER["Service owner / senior engineer"]
    REVIEW["Named human reviewer and approver"]
  end
  subgraph AI["Coding-agent support"]
    HOST["Available coding-agent host"]
    CONTEXT["Scoped task context + repository evidence"]
    TOOLS["Approved local tools / reviewed integrations"]
    HOST <--> CONTEXT
    HOST <--> TOOLS
  end
  subgraph DEV["Development boundary"]
    WORKSPACE["Isolated workspace / branch"]
    TEST["Local tests, profiling, IaC preview"]
    PR["Pull request + immutable source revision"]
    WORKSPACE --> TEST --> PR
  end
  subgraph DELIVERY["Independent delivery control plane"]
    CI["Untrusted validation + security checks"]
    ART["Immutable artifact + provenance"]
    GATE["Protected environment + named approval"]
    FED["Short-lived environment-scoped identity"]
    DEPLOY["Deploy exact reviewed artifact / plan"]
    CI --> ART --> GATE --> FED --> DEPLOY
  end
  subgraph RUNTIME["Production and operations"]
    SERVICE["Application / platform / AI workloads"]
    OBS["Metrics, logs, traces, audit and alerts"]
    RECOVER["Rollback, failover, restore and incident response"]
    SERVICE --> OBS --> RECOVER
  end
  OWNER --> HOST
  HOST --> WORKSPACE
  PR --> CI
  PR --> REVIEW
  REVIEW --> GATE
  DEPLOY --> SERVICE
  OBS --> OWNER
~~~

The diagram is logical, not a claim about Papaya's current network or deployment topology.

## 4. How coding agents help without controlling production
For each task, the agent receives an explicit outcome, source revision, scope, environment, data classification, constraints, acceptance and permitted tools. It discovers the actual system before proposing a change. It establishes performance/reliability baselines where relevant, traces dependencies and failure domains, identifies threats and compares options. It then prepares a scoped change and a plan for verifying it. Any production mutation remains in a protected workflow with independent identity and named human approval.

The agent should not automatically add a security gateway, cache, replica, queue, model call or policy service. Every new component adds latency, failure modes, operating burden and cost. Choose the narrowest enforceable control that addresses a demonstrated risk and measure its effect on the hot path.

## 5. Access levels by task risk

| Tier | Work | Agent capability | Independent boundary |
|---|---|---|---|
| T0 — Understand | Explain code, map dependencies, inspect approved docs | Read scoped source/context | No secrets, production data or side effects |
| T1 — Develop | Edit code/tests/config in a workspace, run local checks | Workspace-scoped write and safe local execution | No production credentials or direct deployment |
| T2 — Propose infrastructure | Author IaC, run static policy checks and non-production preview | Scoped read/preview | No production apply, state administration or deploy identity |
| T3 — Non-production release | Deploy approved artifact to isolated dev/staging | Short-lived environment-scoped identity | Protected workflow and auditable action |
| T4 — Production/sensitive operation | Production apply, IAM/network policy change, bulk data export or claim-data access | No autonomous authority by default | Named human approval, independent policy and operation-bound identity; prohibited actions remain denied |

Risk tier is assigned by the task owner and validated by policy. The model cannot promote its own tier through prompt or tool output.

## 6. Controls that enforce these boundaries

### 6.1 Coding-agent runtime and tools
- Run shell/tool execution in an isolated workspace or managed development environment.
- Start from a clean environment: do not mount AWS SSO caches, production CLI profiles, GCP user credentials, SSH keys, browser sessions, Docker/host sockets or unrelated home directories. Block localhost, link-local/cloud-metadata and unapproved egress outside the model.
- Enforce filesystem, process, network and resource limits outside model instructions.
- Maintain an owned, reviewed and version-pinned tool/plugin/MCP catalogue with provenance, permissions, data/egress declaration, tests and revocation.
- Treat repository content, issues, documents, OCR, logs, tool descriptions and tool output as untrusted data.
- Validate every tool action for task, identity, resource, action and expiry. Keep production credentials outside the coding-agent process.

### 6.2 GitHub and CI/CD
- Protect source, workflow, IaC, IAM, tool catalogue and deployment policy with branch protection, CODEOWNERS and required reviews.
- Use minimum per-job GitHub token permissions and immutable third-party action references.
- Separate untrusted PR validation from privileged release/deploy workflows. Ordinary PR jobs receive no production secrets or cloud federation permission.
- Run affected-component tests and dependency analysis; always run global secret scanning and checks for security-critical shared paths.
- Cover SAST, SCA/license, container/image, IaC, Kubernetes manifest, workflow policy, SBOM and provenance as supported by the existing stack.
- Produce immutable artifacts with source SHA, digest and provenance. Promote the same artifact through environments where practical.
- Treat removal as a release-blocking control: inventory repository, organization, environment, runner and cache locations; revoke/rotate static credentials; and prevent protected release until the inventory is clean or an owner-approved, expiring exception exists.

### 6.3 Production approval and cloud identity
Every production change requires a named human reviewer/approver, whether the change originated from an engineer or an agent. Immediately before mutation, a protected workflow or deployment broker must atomically re-fetch and verify approval against the exact PR/commit, test results, artifact digest or IaC plan digest, target environment, workflow run and deployment identity. Any change to the commit, artifact, plan or environment invalidates approval; use a single-use approval or a record that is explicitly safe to replay. Direct provider calls and stale-job reruns remain denied.

Use short-lived federation rather than stored cloud keys:
- AWS: GitHub OIDC to dedicated validation/preview, non-production and production roles. Restrict trust to the expected repository, ref/workflow and protected environment; verify actual token claims before deployment.
- GCP: GitHub OIDC through Workload Identity Federation to narrowly scoped service accounts/resources. Separate validation, non-production and production trust.
- Grant `id-token: write` only to the job that exchanges the token; it is not itself permission to mutate cloud resources.
- k0s workload service accounts are distinct from CI identities. Enforce RBAC, admission, Pod Security and NetworkPolicy.
- Firebase preview and production environments must not share production data/services with untrusted preview code.

### 6.4 Infrastructure ownership
Preserve the stated Pulumi and Serverless Framework responsibilities. Each resource/stack has one authoritative IaC owner. Pulumi-managed infrastructure remains under Pulumi state; Serverless owns its service/CloudFormation lifecycle. Discover the current owner for ECS/EC2, k0s provisioning and Firebase deployment before changing it. Do not introduce a Terraform migration without an explicit platform decision and state/ownership plan.

## 7. Performance, reliability and HA/DR
Security controls must not silently become a latency or availability regression.

- Establish workload shape and baseline: p50/p95/p99 latency, throughput, concurrency, errors, saturation, queue age, deployment lead time and cost per unit as applicable.
- Keep synchronous authorization and policy checks off hot paths where equivalent enforcement can occur at a safer boundary; when synchronous checks are necessary, measure latency, cache semantics, timeout and fail-open/fail-closed behavior.
- Bound retries, timeouts, tool loops, model calls, concurrency and queue replay. Use idempotency, backpressure, circuit breakers and load shedding to prevent amplification.
- Model failure of identity providers, CI runners, policy services, model providers, DNS, regions, databases and queues. Avoid making a new centralized gateway a single point of failure.
- Define SLO, error budgets, RTO and RPO with service/business owners. They are unknown until supplied.
- Validate backup restoration, failover/failback, data integrity, rollback and degraded-mode behavior. Redundancy alone is not evidence of HA/DR.
- Measure developer friction, CI feedback time, review latency and change failure rate. Optimize safe throughput, not raw agent autonomy.

## 8. Production AI workloads and data protection
Production claim/document/FWA agents are application workloads, not developer coding agents. Maintain a versioned workload manifest for each one: trigger, task identity, tenant/purpose inputs, approved model/provider, typed tools, resource/action allowlist, data classes, state stores, downstream effects, human-review requirement, budgets and owner. Runtime denies calls without a matching manifest entry. Use separate workload identities and route access through application APIs/tool authorization that checks task identity, insurer tenant, resource, action and purpose. Do not expose broad database, object-store or queue credentials to the model.

Treat uploaded PDFs, OCR, emails, partner payloads and retrieved text as untrusted. Derive tenant, purpose, jurisdiction and resource context from an authenticated task context outside the model; bind it to server-issued request metadata and reject missing, conflicting or model-supplied context. Require tenant-qualified cache keys, queue envelopes, object paths, retrieval filters and audit records. Carry authorization through GraphQL resolvers, PostgreSQL/RLS where appropriate, object storage, queues, caches, vector/retrieval stores and analytics. Validate generated SQL, GraphQL, HTML, shell, infrastructure and structured outputs before downstream use.

Apply data minimization and encryption. Enforce an approved route policy before model invocation and failover, keyed by data classification, tenant/country/contract, provider, model, region, retention and logging mode; deny unknown or noncompliant routes and record the decision without unnecessary payloads. Legal/privacy owners must determine HIPAA and regional applicability from actual entity roles, contracts, data flows and jurisdictions. This proposal does not claim compliance.

## 9. Observability, incident response and recovery
Correlate:

`Task → Agent Session → Tool Call → Repository/Branch → PR → Commit SHA → CI Run → Artifact Digest → Approval → Deployment Identity → Runtime Event`

Capture actor/workload identity, target, action, decision, timestamp and correlation ID. Avoid centralizing raw prompts or sensitive payloads by default.

For production-AI executions also capture model/provider version, prompt/policy version, retrieval provenance, tool decision ID and workload-manifest version. Gate model/provider/prompt/tool changes on an owner-approved evaluation bundle covering benign, adversarial, cross-tenant, malformed-document, provider-failure, replay and cost-abuse cases; support version pinning and rollback.

Assign owners for agent runtime, IAM, tool catalogue, CI security, data privacy, cloud operations and incident command. The kill-switch playbook should stop sessions/workers, deny new tool calls, revoke task credentials, block relevant egress, hold queued/in-flight work, disable compromised tools, quarantine affected artifacts, preserve evidence, assess tenant/data impact and execute approved rollback/recovery.

## 10. Rollout and acceptance
1. **Inventory and contain:** agents, tools, identities, production-capable profiles, static CI credentials, data flows, IaC owners and approval paths.
2. **Low-risk pilot:** isolated workspaces, synthetic data, read/edit/test/PR only; verify capture, identity and denial paths.
3. **Secure delivery:** harden CI, replace static cloud keys with federation, protect artifacts and exact-change approvals.
4. **Operational assurance:** exercise performance guardrails, alert ownership, kill switch, revocation, restore, failover and rollback.
5. **Expand based on results:** review incidents, false positives, developer friction, cost and control effectiveness after each significant change to an agent, tool or model.

The [requirement-to-control matrix](control-to-enforcement-matrix.md) traces D-01..D-10 to owners, enforcement points, proposed tests and evidence. The [rollout and assurance matrix](rollout-and-assurance.md) contains 32 proposed acceptance tests (AT-01..AT-32), including a test that verifies coding agents and production-AI workloads cannot access each other's data or tools (AT-32). They have not been run against Papaya infrastructure. A control without an enforcement point, negative test, evidence source and owner remains open.

## 11. Assumptions and residual risks
Exact AWS account layout, GCP project topology, network boundaries, runner type, Pulumi backend, k0s topology, repository paths, deployment mechanisms, SLOs, RTO/RPO and legal applicability are unknown. Validate them before implementation.

Residual risks include prompt injection, compromised tools/runners, human approval error, provider retention/region obligations, IAM misconfiguration, tenant isolation defects below the agent layer and operational gaps. These require continuous testing, monitoring and named ownership.

See also: [requirements](requirements-and-acceptance.md), [control matrix](control-to-enforcement-matrix.md), [threat model](threat-model.md), [architecture](architecture.md), [secure delivery workflow](secure-delivery-workflow.md), [rollout and assurance](rollout-and-assurance.md).
