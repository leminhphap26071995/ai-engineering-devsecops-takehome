# Requirement-to-control and evidence matrix

## Purpose and interpretation

This matrix maps each scenario risk to a proposed control, enforcement point, owner, test and evidence. It does not show that Papaya has deployed or tested those controls.

- Employer requirements E-01..E-06 are recorded in [requirements and acceptance](requirements-and-acceptance.md).
- Scenario-derived risks D-01..D-10 are the rows below.
- AT-01..AT-32 are proposed acceptance tests in [rollout and assurance](rollout-and-assurance.md). They are not run against Papaya.
- The DevSecOps Engineer integrates the design. Each specialist contributes detail for the controls and evidence in their area.
- No SLO, RTO, RPO, cloud account, project, repository path, service topology or legal applicability is inferred where the employer has not supplied it.

## Scenario requirement mapping

| Requirement | Required outcome | Primary enforcement point | Accountable design owner | Proposed acceptance | Evidence to collect |
|---|---|---|---|---|---|
| D-01 — developer agent inherits production-capable AWS SSO | Coding agent cannot read or use developer production credentials; fast non-production development remains available | OS/runtime isolation, credential-store/mount policy, separate task identity, cloud IAM deny | DevSecOps + AI Agent Security; DevOps for cloud identity | AT-01, AT-11, AT-16 | Denied credential-path and production API attempts; runtime mount/identity policy; cloud audit event |
| D-02 — permission prompts may be disabled | Security remains effective even if prompts are bypassed or disabled | OS process/filesystem/network controls, CI policy, repository protections and cloud-side authorization | AI Agent Security; DevSecOps integrates | AT-02, AT-04, AT-11 | Prompt-injection and direct-tool bypass attempts fail at independent enforcement points and emit attributable events |
| D-03 — MCP/plugins installed ad hoc | Only owned, reviewed, versioned and revocable tools can be used | Curated marketplace/registry, provenance and digest verification, permission/data/egress review, runtime allowlist | AI Agent Security; Security Assurance for evidence | AT-03, AT-23, AT-25 | Unapproved source/version is denied; approved tool owner, version, digest, permissions and revocation are auditable |
| D-04 — long-lived GitHub/AWS credentials in CI | Remove/rotate static credentials and use minimum job permissions plus short-lived federation | GitHub workflow permissions, protected reusable workflows/environments, AWS OIDC and GCP WIF trust/IAM | DevOps; DevSecOps accountable for integration | AT-05, AT-06, AT-16, AT-17 | Static credentials absent/revoked; untrusted PR has no privileged secrets; unapproved repo/ref/workflow cannot exchange cloud identity |
| D-05 — every production change needs named human approval | Production mutation is impossible outside a protected path; approval binds to exact change | Protected branch/environment, required named reviewer, exact SHA/artifact/plan/environment binding, cloud trust | DevOps for release path; human service/change owner approves | AT-04, AT-07 | Approval identity/time and reviewed SHA/artifact/plan match the deployed input; changed inputs invalidate approval |
| D-06 — fragmented monitoring and informal on-call | Agent/tool/change/deploy/runtime events are correlated to owned response and recovery | Centralized/correlated audit and telemetry, alert routing, named service/on-call ownership, incident runbook | DevOps + service owner; Security Assurance for audit evidence | AT-09, AT-10, AT-22 | One traceable incident timeline; alert reaches named owner; kill switch, revocation and rollback/restore actions are recorded |
| D-07 — one monorepo for application and IaC | Change-aware validation covers transitive dependencies without skipping global security controls | GitHub Actions dependency/path analysis, always-on security checks, CODEOWNERS and protected workflow/IaC paths | DevOps + Technical Lead; DevSecOps integrates | AT-05, AT-06, AT-23 | Representative shared dependency change triggers affected downstream checks; privileged paths require designated review |
| D-08 — AWS, GCP, k0s and Firebase coexist | Each platform has an explicit identity, deployment and isolation boundary; no credential or preview crosses environments | AWS IAM/OIDC; GCP WIF/service accounts; k0s RBAC/admission/NetworkPolicy; isolated Firebase projects/backends | DevOps; AI Native for production AI workload identity | AT-16, AT-17, AT-18, AT-28 | Unapproved federation denied; privileged pod denied; preview cannot reach production backend/data; workload identities remain scoped |
| D-09 — production AI reads untrusted partner/member documents | Document/OCR content cannot expand tool authority, disclose secrets or cause unchecked side effects | Untrusted-content boundary, application tool authorization, typed output validation, egress controls, clear budgets and replay safety | AI Native + AI Agent Security; DevSecOps integrates | AT-02, AT-12, AT-20, AT-24, AT-26, AT-32 | Malicious document cannot trigger cross-tenant access or unauthorized tool action; output/schema violations and replay are rejected/audited |
| D-10 — multiple insurer tenants and countries | Tenant/resource/action authorization and jurisdiction/contract constraints follow data across every access path | GraphQL/API authorization, PostgreSQL/RLS where appropriate, S3, queues, caches, vector/retrieval stores, provider/region and retention policy | AI Native + Security Assurance; service/data owner decides applicability | AT-08, AT-12, AT-19, AT-29, AT-32 | Cross-tenant requests return no data; tenant context is enforced in cache/queue/retrieval; disallowed provider/region/retention route is blocked |

## Cross-cutting engineering quality

### Rules that apply across requirements

These rules make the D-01/D-02/D-03/D-04/D-05/D-09/D-10 controls testable without claiming they have been implemented:

| Rule | Enforcement and proposed test | Evidence / owner |
|---|---|---|
| Coding agents and production AI workloads are isolated from each other | Separate identities, network policy and resource/application authorization deny coding-agent access to production-AI data and deny production-AI access to GitHub administration, CI configuration, plugins, workspaces and deployment roles; test both directions in AT-32 | Denied requests and audit events; DevSecOps, AI Agent Security and AI Native |
| Agent runtime has no alternate credential or network path | Clean environment, no host/socket mounts, no SSH forwarding, no localhost/link-local/cloud-metadata access, child-process limits and default-deny egress; exercise credential enumeration, metadata, socket, DNS-rebinding and direct-API bypasses | Runtime admission/denial logs and cloud audit; AI Agent Security |
| Tools are admitted by artifact identity, not prompt intent | Verify publisher/source, immutable digest, locked dependencies/SBOM and permission manifest; fail closed on direct URL, sideload, digest/dependency drift or revoked tool | Admission record and revocation event; AI Agent Security, Security Assurance |
| Production-AI authority is manifest-bound and data context is non-model-controlled | Versioned workload manifest gates tools/resources/actions; authenticated server-issued tenant/purpose/jurisdiction context is required in tenant-qualified cache, queue, object and retrieval paths; model-supplied or conflicting context is rejected | Manifest, route decision, tenant-qualified audit record and negative result; AI Native, service/data owner |
| Protected deployment approval is atomic and non-replayable | Immediately before mutation, re-fetch approval and match SHA, artifact/plan digest, target, workflow run and deployment identity; deny substitution, direct provider calls and stale reruns | Immutable approval/deployment record and provider audit; DevOps and human change owner |

AT-32 is proposed and not run. The detailed environment, identities, manifests, routes and owner decisions remain organization-specific unknowns.

| Quality attribute | Required design method | Accountable owner | Proposed acceptance | evidence to collect |
|---|---|---|---|---|
| Performance and developer throughput | Establish workload and CI/review baseline; measure p95/p99, throughput, errors, saturation, queue age, CI feedback and cost; avoid unnecessary synchronous gateways | DevSecOps + DevOps; service owner sets target | AT-30 | Before/after measurements under owner-approved representative workload; no agreed SLO/error-budget or developer-feedback regression |
| Reliability, HA and DR | Map failure domains; define owner-approved SLO/RTO/RPO; validate backup restore, failover/failback, data integrity, rollback and degraded mode | DevOps + service owner; DevSecOps integrates | AT-10, AT-22, AT-31 | Observed restore/failover result, achieved RTO/RPO, data-integrity checks and recovery ownership |
| Cost and denial-of-wallet | Set limits on agent/tool/model/queue retries, concurrency, token use, runtime and spend; monitor cost per unit | AI Native + DevOps | AT-20, AT-26, AT-30 | Enforced limits and audit/alerts when a limit is reached; prevent retry loops and cascading failures |
| Evidence and auditability | Correlate task/session/tool/PR/SHA/CI/artifact/approval/deployment/runtime and incident | DevOps + Security Assurance | AT-09, AT-22 | Attributable end-to-end timeline without centralizing raw sensitive payloads by default |

## Open organization-specific inputs

Papaya must supply or validate these before production implementation:
- AWS account/role layout, GitHub organization/repository and protected environment names;
- GCP project/provider/service-account identifiers and approved attribute mapping;
- k0s cluster topology, identity integration and admission policy;
- Firebase project/backend separation and deploy mechanism;
- actual monorepo paths, CODEOWNERS and dependency graph;
- service owners, workload profiles, SLOs, error budgets, RTO/RPO and maintenance windows;
- tenant/country data-flow map, insurer contracts, provider/subprocessor/region and retention rules;
- legal/privacy determination for HIPAA and applicable regional obligations.

Until supplied, use explicit placeholders and mark the corresponding implementation detail UNKNOWN. The reference design must not fabricate these values.
