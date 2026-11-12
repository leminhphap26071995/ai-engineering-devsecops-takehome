# DevSecOps Engineer — End-to-end engineering workflow

## Phase 1 — Intake and system discovery
1. Recover the goal, requirement IDs, source revision, environment, constraints and acceptance.
2. Identify affected services, owners, users, data classes, critical dependencies and non-goals.
3. Inspect repository structure, IaC, pipelines, runtime topology, deployment process, dashboards, incidents and runbooks where available.
4. Trace request, identity, data and control flows. Mark unobserved topology UNKNOWN; do not design from guessed architecture.

## Phase 2 — Baseline and risk
5. Establish relevant baseline: traffic, latency p50/p95/p99, error rate, saturation, queue age, availability, deployment lead time, failure rate and cost. Select only metrics relevant to the task.
6. Identify assets, threats, failure modes, blast radius, reversibility and external dependencies.
7. Model normal, degraded, partial-failure and recovery behavior. Include retries, timeouts, duplicate events, state drift and credential compromise.

## Phase 3 — Options and design
8. Compare at least the viable alternatives that materially affect security, performance, availability, cost or operating burden.
9. Define service and infrastructure ownership, interfaces, identity boundaries, data paths, SLO implications and operational responsibilities.
10. Design security controls at enforceable layers; for each, state policy, enforcement point, bypass attempt, negative test, telemetry and owner.
11. Design capacity/scaling, failure isolation, HA/DR, backup/restore and rollback proportional to the workload's criticality.
12. Record decisions, assumptions, rejected options, unresolved questions and measurable acceptance. Do not invent targets.

## Phase 4 — AI-assisted execution
13. Decide which subtasks are suitable for deterministic scripts, coding-agent analysis, coding-agent edits, specialist review or human judgment.
14. Give the agent only required context and least-privilege tools. Treat repository content, tickets, logs, documents and tool output as untrusted inputs.
15. Have AI explain its understanding, affected paths, proposed change, risks and test plan before material edits.
16. Permit bounded changes only in the authorized workspace/branch. Keep production credentials and irreversible operations outside the agent's authority.
17. Review generated code/config/IaC as engineering work: semantics, dependency effects, security, performance, resilience, cost and rollback.

## Phase 5 — Verification and release
18. Verify functional contracts, security denials, performance budgets, resilience and operational behavior as applicable.
19. Compare results to the baseline and acceptance; inspect tail latency, saturation and downstream effects, not only average throughput.
20. Use staged rollout, canary/feature flags or maintenance windows when justified. Bind privileged deployment to exact reviewed inputs and independent human approval.
21. Stop/rollback when health, security or error-budget guardrails are breached. Preserve the previous known-good artifact and recovery path.

## Phase 6 — Operate and improve
22. Confirm dashboards, alerts, runbooks, ownership, on-call/escalation, backup/restore and incident procedures.
23. Correlate task/session, change, CI run, artifact, approval, deployment and runtime evidence.
24. Record residual risks, operational handoff and follow-up actions. Revisit controls after incidents, platform changes or agent/model/tool changes.

## Required task output
Use a concise decision record:
- goal and acceptance;
- source/revision and inspected evidence;
- affected systems and dependencies;
- baseline and constraints;
- options and trade-offs;
- selected design/change;
- security/performance/reliability impact;
- rollout/rollback and operations;
- tests, observed results and evidence;
- unknowns, residual risks and owner decisions.

Do not force every phase onto a documentation-only or low-risk task. Scale depth to impact, criticality and reversibility; never skip a phase that is necessary for the requested outcome.
