# Operations, observability and incident response

## Correlation model

`Task ID → Agent Session ID → Tool Call ID → Repository / Branch → PR → Commit SHA → CI Run → Approval → Deployment Identity → Cloud Event`

Each stage should emit timestamp, actor/workload identity, target, action, decision and correlation identifier. Avoid logging sensitive payloads.

## Security signals

- Denied access to secret stores, production APIs or out-of-scope files.
- Unusual network egress or access to unapproved domains.
- MCP/plugin version drift or unexpected tool registration.
- Privilege escalation, workflow permission expansion or policy-file modification.
- Agent attempting self-approval, production deployment or audit tampering.
- Cross-tenant access denials and anomalous bulk reads.
- CI scan failures, artifact digest mismatch or invalid provenance.

## Incident playbook

1. Stop the affected agent session, orchestrator and workers; deny new tool calls and pause affected queues/workflows.
2. Revoke task/workload identities and short-lived credentials; invalidate tokens and active sessions.
3. Disable compromised MCP/plugin/tool grants, block relevant egress and prevent new execution through the affected identity.
4. Hold or quarantine queued/in-flight actions, branches, artifacts and the untrusted tool/plugin version; prevent retry/replay until reviewed.
5. Preserve session, tool, CI and cloud audit evidence with correlation IDs and controlled access.
6. Determine data exposure, affected tenants, systems and jurisdictions.
7. Rotate exposed secrets and investigate lateral movement.
8. Roll back or disable affected deployment if required.
9. Notify security/privacy/legal owners under the applicable incident process.
10. Record root cause, control failure and remediation.
11. Retest the full attack path, including post-revocation attempts, and update policy/monitoring.

Assign explicit owners for agent platform, IAM, tool registry, CI security, data privacy, cloud operations and incident command.


## Operating metrics

Establish baselines before setting targets:
- Agent sessions linked to an approved task, repository and risk tier.
- Coding-agent sessions without production-capable credentials.
- Approved plugin/MCP coverage, version drift and revocation time.
- Count of long-lived GitHub/cloud credentials remaining.
- Production changes with named approval bound to exact SHA, artifact and plan.
- CI security coverage across affected monorepo components and shared dependencies.
- Cross-tenant negative-test coverage and regression rate.
- Time to stop an agent, revoke identity, block egress and contain in-flight work.
- Mean time to detect/respond, rollback success and audit-evidence completeness.
- Developer cycle time and approval latency, measured alongside control effectiveness.

Do not set arbitrary percentage targets before the inventory and baseline are known.
