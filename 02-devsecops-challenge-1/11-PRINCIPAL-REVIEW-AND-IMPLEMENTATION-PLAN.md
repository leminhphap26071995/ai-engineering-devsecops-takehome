# 11. Principal-Level Design Review and Delivery Plan

## Executive position

The design should make coding agents productive without treating model behavior, prompts or IDE permission dialogs as a security boundary. A coding agent is an untrusted workload with access to tools, source and potentially sensitive context. Authorization must be enforced by operating-system isolation, tool policy, repository controls, CI and cloud IAM outside the model.

The target is **bounded autonomy + independent authorization + evidence-backed delivery**.

This is a candidate reference design. It is not a claim that Papaya has deployed these controls or that the candidate has audited its environment.

## What the initial baseline gets right

- Separates human authority from agent execution.
- Treats retrieved content and tool output as untrusted.
- Rejects inherited developer production credentials and self-approval.
- Connects agent sessions to repository, commit, CI, approval and cloud audit evidence.
- Recognizes cross-tenant data, multi-cloud identity and jurisdiction-specific obligations.
- Keeps legal compliance and production implementation claims outside the candidate's evidence.

## Principal-level critique: gaps to close

| Gap in a generic design | Why it matters | Required refinement |
|---|---|---|
| "Use a policy gateway" without deployment detail | A box on a diagram is not an enforcement point | Define enforcement at runtime sandbox, tool broker, network egress, GitHub branch/environment rules and cloud IAM; if no gateway product exists, compose controls rather than invent one |
| Agent runs on an engineer laptop with AWS SSO | Developer profiles may reach production; the agent can inherit cached sessions, env vars, SSH keys or CLI config | Prefer isolated ephemeral devbox/VM/container with no production profile; separate agent identity; deny access to host credential stores and production endpoints |
| Permission prompts disabled for speed | UI prompts can be bypassed or misconfigured | Enforce policy outside the model and IDE; agent autonomy is limited by OS, network, identity and cloud-side policy |
| Tool/plugin review described only as an allowlist | A reviewed tool can change after approval or be compromised upstream | Inventory publisher, source, immutable version/digest, permissions, data classes, egress, transitive dependencies, test results, owner and revocation path |
| Prompt injection treated as a prompt problem | Claim documents and tool results can contain indirect instructions | Mark retrieved content untrusted; separate data from control; validate tool arguments; authorize every tool call independently; restrict reachable data, destinations and side effects |
| Multi-cloud identity described generically | AWS IAM and GCP IAM have different trust and policy semantics | Use AWS OIDC role trust and GCP Workload Identity Federation separately; test each provider's claims and denied paths |
| IaC ownership not explicit | Pulumi, Terraform and Serverless can compete over the same resource | Adopt the ownership model in [Multi-cloud IaC strategy](10-MULTICLOUD-IAC-STRATEGY.md) |
| Tenant isolation only described at API level | Object stores, async queues, vector stores, caches and analytics can leak tenant context | Carry tenant identity end-to-end; authorize at API/service, DB query/RLS where appropriate, object path/key policy, queue consumer and retrieval layer; test cross-tenant negatives |
| Raw audit logs may contain sensitive payloads | Prompts, tool arguments and transcripts can capture PII/secrets | Log metadata and decisions by default; minimize/redact payloads before centralization; apply access, retention, legal hold and deletion policy |
| "Kill switch" is underspecified | Stopping a UI session does not revoke issued credentials or in-flight work | Stop session/tool broker, revoke short-lived credentials, block egress, disable identity, quarantine branch/artifact and preserve audit evidence |
| Compliance named without applicability analysis | HIPAA and regional laws depend on entity, role, processing, contract and jurisdiction | Legal/privacy owners map data flows, roles, lawful basis, BAA/contract, residency, subprocessors, transfers, retention and incident duties |
| No measurable operating model | Security controls can degrade silently | Define control owners, alert routing, on-call, SLOs, recovery objectives and periodic control tests from observed baselines |

## Target trust zones

1. **Human and work-management zone:** approved task, owner, risk tier, scope and acceptance.
2. **Agent execution zone:** isolated ephemeral workspace; no production credentials; no broad host filesystem or credential-store access.
3. **Tool/data access zone:** reviewed tool registry, task-scoped capability broker, schema validation, egress restrictions and audit correlation.
4. **Source and CI zone:** protected GitHub repository, CODEOWNERS, required checks, pinned actions, minimal workflow token permissions and exact-SHA evidence.
5. **Cloud control zone:** separate AWS and GCP identities, protected production environments, cloud-side trust policies and independent approval.
6. **Production/data zone:** tenant-scoped workloads, secrets, regulated data and independently monitored operations.
7. **Evidence zone:** access-controlled, integrity-protected audit metadata, source revision, CI receipts, approvals and incident evidence.

## Risk-tiered autonomy

| Tier | Example | Agent capability | Required control |
|---|---|---|---|
| T0 — Read-only | Explain code, inspect docs, draft plan | Read approved repo/context | No secret or production data access |
| T1 — Development | Edit source/tests, run local tests | Write inside assigned workspace | Isolated runtime, branch-only Git access, no privileged credentials |
| T2 — Infrastructure proposal | Author Terraform/Pulumi/Serverless changes, run static checks and speculative plan | No apply or state-admin access | IaC scan, policy test, protected-path review, restricted plan identity |
| T3 — Non-production deployment | Deploy approved artifact to dev/staging | Short-lived environment-scoped identity | Protected environment, approval as risk requires, audit and rollback |
| T4 — Production or sensitive-data operation | Production apply, IAM/org policy mutation, bulk export, real claims data access | No autonomous authority | Named human approval, independent policy decision, operation-bound credential and cloud-side enforcement; some actions remain prohibited |

The model cannot promote its own task to a higher tier. Risk tier and capability are assigned by an external policy owner.

## Minimum enforcement design

### Agent host/runtime
- Use ephemeral, isolated workspaces; destroy or re-image after high-risk sessions.
- Deny host credential stores, production CLI profiles, browser SSO sessions, SSH keys, Docker socket and unrestricted host mounts.
- Apply filesystem, process, network and resource limits.
- Restrict outbound destinations to approved model/tool endpoints; log denied egress.
- Separate task identities and sessions; expire credentials and revoke on termination.
- Keep the agent runtime separate from the production workload runtime.

### Tool/MCP boundary
- Treat tool descriptions, results and remote content as untrusted input.
- Use typed schemas, strict argument validation, per-tool authorization and output filtering.
- Deny arbitrary shell, unrestricted network, secret retrieval and destructive APIs by default.
- Bind each grant to task, identity, resource, action and expiry.
- Maintain tool inventory, provenance, immutable version, security review, owner and emergency revocation.
- Correlate tool call IDs with task/session IDs; do not log raw sensitive payloads by default.

### GitHub and CI
- Branch protection, required independent review and CODEOWNERS for workflows, IaC, IAM, policy and deployment files.
- Minimal GITHUB_TOKEN permissions; pin third-party actions to full commit SHAs; restrict reusable workflows.
- Separate untrusted pull-request validation from privileged release/deployment workflows.
- Run tests, SAST, SCA, secret scanning, IaC policy/security scanning, container/image scanning, Kubernetes manifest policy and artifact provenance checks.
- Require checks to report against the exact head SHA; reject stale approvals after the diff changes.
- Protect workflow and policy files from self-approval or unreviewed modification.

### AWS / GCP / k0s
- AWS: separate agent, CI plan, staging deploy and production deploy roles; use OIDC and restrictive trust/permission policies; CloudTrail and service logs.
- GCP: use Workload Identity Federation; separate model inference, data access and infrastructure administration; organization policies and Cloud Audit Logs.
- k0s: namespace/service-account separation, RBAC, Pod Security Standards, NetworkPolicies, quotas, admission controls, signed/pinned images and audit logging.
- Never reuse one broad identity across clouds, tenants or environments.
- Do not assume Kubernetes RBAC alone provides tenant isolation for application data.

## AI-specific security evaluation

Build repeatable red-team tests from the actual use cases:

- Direct and indirect prompt injection in claim PDFs, OCR text, emails, issue descriptions, PR comments and MCP results.
- Attempts to make an agent reveal system prompts, environment variables, credentials or another tenant's data.
- Tool-call abuse: arbitrary shell, SSRF, outbound exfiltration, unauthorized file reads, destructive API calls and privilege escalation.
- RAG/vector isolation: tenant metadata filter bypass, poisoned documents, stale ACLs and retrieval from another insurer.
- Output handling: generated SQL, GraphQL, HTML, shell and infrastructure configuration must be parsed/validated before execution.
- Resource abuse: unbounded loops, repeated tool calls, expensive inference, queue amplification and denial-of-wallet.
- Model/provider changes: regression tests for tool behavior, refusal boundaries, data retention and output quality.

Use OWASP's current GenAI/LLM security material and NIST AI RMF/GenAI Profile as risk and evaluation references; they guide risk management but do not certify the system.

## Security control evidence model

For every high-risk control, retain:

Risk → Requirement → Policy → Enforcement point → Negative test → Observed result → Evidence reference → Owner

Examples:
- Prompt injection → no unauthorized tool action → tool broker authorization → malicious document test → denied tool call + correlated audit event.
- Production bypass → agent cannot deploy → cloud IAM + protected environment → direct API attempt → access denied + audit event.
- Cross-tenant read → no insurer data crossover → service/data authorization → tenant A requests tenant B object → denied + no data returned.
- Terraform state exposure → agent cannot read state → backend IAM → agent state read attempt → denied + state access log.

A written control without an enforcement point and falsifiable test is a design assertion, not verified security.

## Delivery plan for this assessment

The deadline is 2026-11-14 (the HR email has no exact cutoff hour). Prioritize the employer's acceptance gates over building an operational platform.

| Phase | Work | Exit evidence |
|---|---|---|
| P0 — Local capture gate | Install Cursor Desktop on Windows; verify local native transcript capture using a disposable workspace and harmless probe | Exact raw session file exists; content and completeness inspected; capture procedure recorded |
| P1 — Coding-agent challenge | Cursor Agent reviews the challenge requirements, attacks the architecture, proposes changes and edits the draft | Complete unedited native transcript; reviewed diff; findings resolved or recorded |
| P2 — Design closure | Reconcile AWS/GCP identity, Pulumi/Serverless/Terraform ownership, k0s controls, tenant/data protection, CI/CD, operations and residual risk | Requirement-to-control-to-test matrix; coherent diagrams; no conflicting IaC ownership |
| P3 — Repository verification | Markdown links, Mermaid syntax, secret/PII scan, raw transcript manifest reconciliation, Git diff review | Commands/results and exact SHA recorded; no unresolved critical finding |
| P4 — Owner acceptance | Review claims, personal answers, repository access and one-link submission | Owner approval and confirmed submission evidence |

Do not spend the remaining deadline implementing a sample production cloud landing zone unless the employer explicitly asks. A precise reference design and tested local evidence package is more defensible than an unrequested, partially working cloud deployment.

## Skeptical self-review

- **Overengineering risk:** A dedicated policy gateway, custom agent broker or cross-cloud abstraction may be excessive if Papaya does not have one. Start with enforceable host isolation, cloud IAM, GitHub protection and approved tool registry; introduce a gateway where centralized tool mediation is required.
- **Vendor-lock-in risk:** Do not assume Claude Code, Cursor or one model provider is a security control. Keep authorization and audit independent of model vendor.
- **False assurance risk:** A model refusing a dangerous prompt is not proof that the action is blocked. Test the actual API/credential/network boundary.
- **IaC sprawl risk:** Terraform is not automatically superior to Pulumi for multi-cloud. Retain current owners; introduce Terraform only with explicit scope and state ownership.
- **Compliance overclaim risk:** ISO 27001, HIPAA and regional privacy obligations require applicability and evidence; do not label the proposal compliant or certified.
- **Operational gap:** A kill switch, central logging and rollback are incomplete until owners, permissions, runbooks, retention and recovery are exercised.
- **Human-factor risk:** Named approval can become rubber-stamping. Require reviewer context (diff, plan, risk, tests, artifact digest), separation of duties and stale-approval invalidation.

## Official and primary references

- [AWS Prescriptive Guidance — Security for agentic AI](https://docs.aws.amazon.com/prescriptive-guidance/latest/agentic-ai-security/)
- [AWS — Secure development practices for agentic AI](https://docs.aws.amazon.com/prescriptive-guidance/latest/agentic-ai-security/best-practices-dev-practices.html)
- [AWS IAM security best practices](https://docs.aws.amazon.com/IAM/latest/UserGuide/best-practices.html)
- [GitHub Actions OIDC to AWS](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments/oidc-in-aws)
- [Google Cloud — Generative AI security best practices](https://docs.cloud.google.com/docs/security/genai-security-bps)
- [Google Cloud — Workload Identity Federation](https://docs.cloud.google.com/iam/docs/workload-identity-federation)
- [Google Cloud — Enterprise foundations blueprint](https://docs.cloud.google.com/architecture/blueprints/security-foundations)
- [OWASP GenAI LLM Top 10 (2026)](https://github.com/GenAI-Security-Project/GenAI-LLM-Top10)
- [NIST AI RMF: Generative AI Profile (AI 600-1)](https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence)
- [Kubernetes Pod Security Standards](https://kubernetes.io/docs/concepts/security/pod-security-standards/)
- [Kubernetes Security Concepts](https://kubernetes.io/docs/concepts/security/)
