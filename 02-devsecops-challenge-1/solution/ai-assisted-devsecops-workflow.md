# AI-assisted DevSecOps engineering workflow

## Purpose
Show how a senior DevSecOps engineer should direct a coding agent on real engineering work. The agent is an analysis and execution assistant inside explicit boundaries; it is not the architect of record, production approver or substitute for operational ownership.

The workflow is portable across coding-agent hosts. Host-specific instructions, tool adapters, permissions and transcript capture are implementation details.

## 1. Task contract — what the engineer gives the agent
Every material task should establish:
- **Outcome:** what user, service or operational result must change?
- **System:** repository/service/environment and known architecture.
- **Scope:** affected components, permitted paths/actions and explicit non-goals.
- **Constraints:** security/data classification, performance budget, SLO, availability, cost, compliance and change window where known.
- **Evidence:** source revision, baseline metrics, logs/traces, prior incidents and authoritative docs.
- **Acceptance:** observable functional, security, performance, resilience and operational results.
- **Authority:** read/write boundary, allowed tools, approval owner and prohibited operations.

Missing facts are investigated or marked UNKNOWN; the agent must not invent them.

## 2. How the agent should reason
For a request such as “reduce API latency without weakening tenant isolation or availability”, the agent should not immediately add a cache or change replicas. It should:
1. Restate the outcome and identify measurable acceptance (e.g. p95/p99, error rate, throughput and tenant-isolation invariants).
2. Discover the request path, dependencies, authorization checks, database/query path, cache behavior and deployment topology.
3. Establish baseline and locate the bottleneck using traces, profiles, query plans and saturation signals.
4. Identify security and reliability risks introduced by each candidate change.
5. Compare alternatives and quantify expected cost/latency/availability effects where evidence permits.
6. Propose a minimal reversible change, rollout guardrails and rollback trigger.
7. Implement only in the authorized branch/workspace.
8. Test correctness, isolation, load behavior, failure behavior and regression; compare results to baseline.
9. Report observed improvement, regressions, residual risks and unverified assumptions.

This example is illustrative. No Papaya latency target or production baseline is supplied.

## 3. End-to-end lifecycle

~~~mermaid
flowchart TD
  A["Task + outcome + authority"] --> B["Discover source, system and owners"]
  B --> C["Baseline behavior, SLO and performance"]
  C --> D["Threat + failure-mode + blast-radius analysis"]
  D --> E["Options and trade-off decision"]
  E --> F["Bounded implementation plan"]
  F --> G["Agent assists analysis / code / tests"]
  G --> H["Functional + security + performance + resilience verification"]
  H --> I{"Acceptance satisfied?"}
  I -->|No| J["Diagnose evidence and repair"]
  J --> G
  I -->|Yes| K["Human review + protected release"]
  K --> L["Operate, observe and recover"]
  L --> M["Evidence, learn and update controls"]
~~~

## 4. Work classification and autonomy

| Work type | AI contribution | Human/independent boundary |
|---|---|---|
| Read/understand | Summarize source, trace dependencies, identify unknowns | Engineer validates material interpretations |
| Design | Compare architecture, threat and failure modes | Accountable engineer owns decision |
| Local development | Edit scoped code/config/tests, run safe local tools | Review diff; no production credentials |
| CI analysis | Inspect workflow results/logs, explain failures, propose repair | CI policy and protected jobs enforce permissions |
| Infrastructure | Author IaC, static checks and non-production preview | Production apply/state-admin requires protected workflow and human approval |
| Operations | Analyze sanitized telemetry, draft runbooks and recovery plans | Incident commander/operator controls live production actions |
| Security | Threat model, policy suggestions, negative tests | IAM/runtime/policy engine enforces; security owner accepts residual risk |
| Performance | Profile, model capacity, propose tuning and load tests | Changes require baseline, guardrails and measured comparison |

Autonomy is granted per task and environment, not permanently to an agent identity. Read, edit, execute local tests, access non-production diagnostics and production mutation are distinct capabilities.

## 5. Engineering guardrails

### Security
- Treat source files, issues, documents, logs, OCR, tool descriptions and tool results as untrusted content.
- Never place production credentials or sensitive customer data in the agent context.
- Enforce authorization at OS/runtime, repository, CI and cloud layers; prompts only guide behavior.
- Bind production approval to the exact commit, artifact/plan and target environment.
- Test denied paths, not only successful workflows.

### Performance
- Record the baseline and workload shape before tuning.
- Protect p95/p99 latency, throughput, saturation headroom, queue age and cost per unit where relevant.
- Avoid adding synchronous policy calls or centralized gateways to hot paths without measuring latency and availability impact.
- Use caching only with explicit tenant-aware keys, invalidation and stale-data semantics.
- Bound concurrency, retries and model/tool loops to prevent retry amplification and denial-of-wallet.

### Reliability and HA/DR
- Identify failure domains and critical dependencies before adding redundancy.
- Define SLO, RTO and RPO with service/business owners; never invent targets.
- Validate backup restore, failover/failback, idempotency, queue replay, rollback and degraded-mode behavior.
- A control plane, identity provider, model provider or policy service can itself become a dependency; design safe failure behavior.

### Developer throughput
- Keep fast feedback local and deterministic where safe.
- Run focused tests for affected components plus always-on global security checks.
- Parallelize independent analysis, not conflicting writes or dependent decisions.
- Measure CI duration, review latency, change failure rate and developer friction; do not optimize away mandatory review.

## 6. Standard AI response contract
Before material changes, return:
1. understanding and acceptance;
2. source/system evidence inspected;
3. affected components and dependency path;
4. risks and unknowns;
5. options and trade-offs;
6. selected plan, verification and rollback.

After changes, return:
1. exact files/revision changed;
2. commands/tests and observed outputs;
3. security/performance/reliability impact;
4. evidence not available;
5. residual risks and required human approval.

The response is not accepted merely because it is plausible or complete-looking. The engineer verifies source, tests, runtime and consumer behavior.

## 7. Evidence chain
`Task → requirement → source SHA → agent/session → tool/action → diff → CI run → artifact digest → reviewer/approval → deployment → runtime signal → incident/recovery evidence`

Keep metadata and correlation IDs where possible. Do not log secrets or raw sensitive payloads by default. Raw coding-agent transcript requirements are separate from operational audit logs; preserve them unedited when required and safe to share.
