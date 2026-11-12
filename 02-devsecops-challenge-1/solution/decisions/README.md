# Architecture Decision Records

These ADRs capture material decisions for the proposed solution. They are candidate design decisions, not approvals by Papaya.

| ADR | Decision | Status |
|---|---|---|
| [ADR-001](ADR-001-no-production-credentials-in-coding-agent.md) | Coding agents never receive production-capable developer credentials | Proposed |
| [ADR-002](ADR-002-production-approval-bound-to-exact-change.md) | Every production change requires named human approval bound to exact change | Proposed; employer scenario requirement |
| [ADR-003](ADR-003-preserve-pulumi-and-serverless-ownership.md) | Preserve Pulumi and Serverless Framework ownership | Proposed from employer stack |
| [ADR-004](ADR-004-separate-developer-and-production-ai-identities.md) | Separate developer coding-agent and production AI-agent identities/data boundaries | Proposed |
| [ADR-005](ADR-005-untrusted-pr-validation-and-federated-deployments.md) | Separate untrusted PR validation from protected OIDC/WIF deployment | Proposed |

Lifecycle: Proposed → Reviewed by accountable owners → Accepted/Rejected → Superseded. A status change requires a named decision owner and rationale.
