# DevOps Engineer — End-to-end delivery and operations workflow

1. Recover requirement IDs, architecture decisions, exact source SHA, target environment and accountable service owner.
2. Discover actual workflow triggers, permissions, runners, dependency graph, IaC ownership, deployment paths, runtime topology and recovery procedures.
3. Trace source → build → test → artifact → provenance → approval → federated identity → deployment → runtime.
4. Establish baseline for pipeline duration, deploy frequency/failure, latency p95/p99, throughput, saturation, queue age, availability and cost where relevant.
5. Design least-privilege workflow permissions and environment-specific AWS OIDC/GCP WIF trust; test wrong repo/ref/workflow/environment denial.
6. Validate IaC preview/plan, state protection, drift, ownership and blast radius. Never let two tools reconcile the same resource.
7. Design deployment strategy, progressive rollout, health gates, rollback/roll-forward and safe database/queue migration behavior.
8. Model overload, dependency failure, retry amplification, node/zone/region outage, identity-provider outage and partial recovery.
9. Define SLO signals, alerts, dashboards, on-call/escalation, backup/restore, RTO/RPO and failover drills with owners.
10. Verify functional, security, performance, resilience and recovery oracles against real evidence; distinguish local tests from provider/production evidence.
11. Return requirement → design/control → enforcement → failure/bypass test → observed evidence → owner, plus residual unknowns.

Scale work to the task. Do not invent runner type, cloud account, SLO, RTO/RPO, capacity or deployment mechanism.
