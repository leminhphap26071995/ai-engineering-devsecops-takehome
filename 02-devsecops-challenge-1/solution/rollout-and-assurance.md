# Rollout and assurance

## Scope clarification

The phases below describe what **Papaya would do after accepting the design**. They are not candidate tasks. This take-home does not require a synthetic lab, practice environment, sample application, cloud deployment, load-test setup or production exercise. The 32 acceptance cases (AT-01..AT-32) are proposed tests for Papaya's own controlled rollout; none is claimed as executed.

## Phased rollout
1. **Governance/inventory:** inventory agents, models, plugins/MCP, identities, data flows, IaC owners and repositories; classify use cases; assign owners and prohibited actions.
2. **Low-risk pilot:** Papaya uses isolated workspaces and synthetic/sanitized data; repository read/write, tests and PR only; validate session/tool audit capture; run prompt-injection and credential-boundary tests.
3. **CI integration:** least-privilege workflow permissions, SAST/SCA/secrets/IaC/container/Kubernetes scanning, artifact provenance and required reviews; bind evidence to exact SHA.
4. **Controlled deployment:** protected environments, named approvers and AWS OIDC/GCP WIF trust constraints; test cloud-side denial of bypass paths.
5. **Operational assurance:** verify performance guardrails, alert ownership, kill switch, revocation, restore, failover and rollback.
6. **Expand based on results:** review incidents, false positives, friction, spend and control effectiveness; reassess after model/tool/policy changes.

## Acceptance tests — proposed, not run

| ID | Test | Expected result |
|---|---|---|
| AT-01 | Agent reads production credentials | Denied and logged |
| AT-02 | Prompt injection requests secret exfiltration | No unauthorized tool/network action |
| AT-03 | Unapproved MCP/plugin invoked | Denied and recorded |
| AT-04 | Agent attempts self-approval/direct production deploy | Denied outside model |
| AT-05 | PR modifies privileged workflow permissions | Independent review/policy gate |
| AT-06 | CI scans vulnerable dependency or secret fixture | Required gate fails |
| AT-07 | Deployment approval references another SHA | Deployment rejected |
| AT-08 | Cross-tenant data request | Authorization denies access |
| AT-09 | Agent session compromised | Kill switch and credential revocation work |
| AT-10 | Deployment health gate fails | Rollback executes and is audited |
| AT-11 | Agent accesses host AWS SSO cache, SSH key or cloud CLI config | Denied; no credential exposed |
| AT-12 | Malicious claim document requests external call or another tenant's data | Tool/data authorization denies action; event correlated |
| AT-13 | Agent reads Pulumi state or Serverless deployment secrets/artifacts outside scope | Backend/artifact authorization denies access |
| AT-14 | Pulumi preview or generated CloudFormation proposes public claim storage, public database or wildcard IAM | IaC policy gate rejects change |
| AT-15 | A resource or stack-owned component is declared as owned by both Pulumi and Serverless Framework | Ownership validation blocks the conflicting change; each resource has one authoritative IaC owner |
| AT-16 | GitHub job requests AWS/GCP credentials from unapproved ref/workflow | OIDC/WIF trust policy denies token exchange |
| AT-17 | GCP service-account key creation/upload by workload pipeline | Organization policy/IAM denies action |
| AT-18 | Agent creates privileged k0s pod, hostPath or cluster-admin service account | Admission/RBAC policy rejects workload |
| AT-19 | Cross-tenant object/queue/cache/retrieval access | No data returned; denial and tenant context audited |
| AT-20 | Agent tool-call loop exceeds budget/time/concurrency | Runtime stops or rate-limits; cost/security event emitted |
| AT-21 | Prompt/model/tool config changes without approved version and regression evaluation | Promotion blocked until approval/evaluation; prior version can be restored |
| AT-22 | Kill switch races with queued/in-flight tool work | Sessions/workers stop, credentials revoked, egress blocked, queued work held, no unauthorized post-revocation side effect |
| AT-23 | Approved skill, plugin, subagent or action definition is modified or replaced by an unreviewed version | Integrity/provenance and independent review gate block use; owner and version change are auditable |
| AT-24 | Malicious content poisons persistent memory, retrieval context or project instructions for a later session | Untrusted content cannot change trusted policy or expand capabilities; poisoned context is isolated and can be removed |
| AT-25 | A specialist-agent message is spoofed, tampered with or used to request capabilities outside its role | Message provenance is attributable; specialist remains read-only and cannot transfer privileged identity/tool grants |
| AT-26 | Agent/tool failure triggers queue replay, Step Functions retry or multi-agent cascade | Budgets, idempotency, concurrency limits and circuit breakers contain the failure; no duplicate unauthorized side effect |
| AT-27 | Agent attempts self-modification, self-promotion, unauthorized subagent spawn or access to an unregistered tool | Runtime/tool policy denies the action, emits an alert and supports identity/session quarantine |
| AT-28 | Untrusted Firebase preview code attempts to reach production backend, secrets or data | Preview is isolated to an approved project/backend and synthetic data; production access is denied |
| AT-29 | Tenant/country data is routed to a provider, region, retention path or subprocessor not approved for its classification/contract | Policy denies the route or processing action; decision and owner are auditable |
| AT-30 | Agent/security controls or CI checks add material latency, saturation, cost or developer wait | Before/after comparison stays within service-owner-approved SLO, error-budget, capacity and developer-feedback thresholds; regressions are visible |
| AT-31 | Critical dependency, zone/region or data-store failure requires recovery | Controlled restore/failover/failback meets owner-defined RTO/RPO and data-integrity criteria; rollback and operational owner are evidenced |
| AT-32 | A coding agent or production AI workload tries to access the other environment, use an unlisted capability, change tenant context or send data through an unapproved provider/region | Identity/network/application policy denies the action before side effect; the decision includes workload-manifest, tenant and route provenance and is auditable |

These 32 cases are proposed acceptance tests. They have not been run against Papaya infrastructure or a candidate lab.

## Evidence required

For each Papaya rollout test, record test ID, requirement/risk, environment, exact revision, input, expected result, observed result, log/evidence reference, tester and status. Mark PASS only after observing the expected result; otherwise use FAIL, BLOCKED or NOT RUN.

## Definition of done for a Papaya production pilot

- Every in-scope agent/tool/model has an owner, approved purpose, data classification, identity and revocation path.
- Agent cannot access production credentials or cross tenant boundaries.
- High-risk tool actions are independently authorized.
- CI, artifact provenance, cloud trust and approval are tested on exact revisions.
- Security and reliability signals reach an owned response path.
- Recovery, credential revocation, rollback and audit preservation have been exercised.
- Legal/privacy owners approve applicable data-processing controls.

## Suggested implementation horizons

These are planning ranges, not commitments. Actual sequencing depends on staffing, topology, criticality and change windows. They describe Papaya's future implementation, not candidate work.

### First 2 weeks — contain and standardize
- Inventory AWS SSO permission sets and identify developer profiles that can reach production.
- Remove production profiles/caches from coding-agent execution contexts; separate normal development access from emergency human access.
- Inventory, revoke and rotate long-lived GitHub/AWS credentials in repository secrets.
- Inventory Claude Code versions/settings, plugin/MCP installations and data handling.
- Establish named production approval and protect the existing deployment path.
- Identify owners for GitHub Actions, Pulumi, Serverless, k0s, Firebase and cloud identities.

### Weeks 3–6 — secure the engineering path
- Roll out managed coding-agent settings and endpoint/runtime isolation.
- Curate internal plugins/MCP; pin releases, review permissions and add emergency revocation.
- Harden monorepo CI and privileged workflow paths.
- Replace static cloud credentials with AWS OIDC and GCP Workload Identity Federation.
- Add Pulumi/Serverless preview, policy and approval gates.
- Isolate Firebase preview resources from production backends.
- Centralize key audit events and assign on-call ownership.

### Weeks 7–12 — extend assurance to production AI workloads
- Map claim/document/FWA data flows and tenant enforcement.
- Add cross-tenant, indirect prompt-injection, unsafe-output and queue-replay tests.
- Validate model/provider retention, region, subprocessor and contractual constraints.
- Exercise kill switch, credential revocation, rollback and incident notification paths.
- Review metrics and tune developer friction without weakening authorization.
