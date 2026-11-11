# 7. Operations, Observability and Incident Response

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

1. Stop the affected agent session and prevent new tool calls.
2. Revoke task credentials and invalidate related tokens/sessions.
3. Quarantine branch, artifacts and untrusted tool/plugin version.
4. Preserve raw session, tool, CI and cloud audit evidence.
5. Determine data exposure, affected tenants, systems and jurisdictions.
6. Rotate exposed secrets and investigate lateral movement.
7. Roll back or disable affected deployment if required.
8. Notify security/privacy/legal owners under the applicable incident process.
9. Record root cause, control failure and remediation.
10. Retest the exploit path and update policy/monitoring.

Assign explicit owners for agent platform, IAM, tool registry, CI security, data privacy, cloud operations and incident command.
