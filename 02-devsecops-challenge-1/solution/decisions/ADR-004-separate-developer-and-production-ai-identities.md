# ADR-004: Separate developer coding agents from production AI workloads

- Status: Proposed
- Decision owner: AI Platform owner + Security/Data owner
- Date: 2026-11-12

## Context
The challenge concerns Claude Code on developer workstations. Appendix A separately describes production claim assessment, document extraction/classification and FWA agents processing partner/member documents and sensitive data.

## Decision
Use distinct runtimes, identities, tool inventories, secrets, network boundaries, data authorization and audit policies. Developer agents operate on source and synthetic/sanitized fixtures. Production AI workloads use service identities and existing application authorization scoped to workload, tenant, purpose and resource. Uploaded documents, OCR, retrieved content and model output are untrusted.

## Consequences and verification
No shared agent credential or data plane. Production AI security requires its own threat model and adversarial tests: indirect prompt injection, cross-tenant retrieval, unsafe output, queue replay and model/provider data handling. Test cross-tenant negatives across API, GraphQL, database, object storage, queues, cache and retrieval.

## Alternatives rejected
One universal agent identity, broad direct DB/object-store access and tenant metadata trusted only because a prompt supplied it.
