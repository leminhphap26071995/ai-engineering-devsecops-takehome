# ADR-001: No production credentials in developer coding-agent execution

- Status: Proposed
- Decision owner: Security/IAM owner (to be assigned by Papaya)
- Date: 2026-11-12

## Context
The scenario says engineers run Claude Code on laptops authenticated to AWS SSO and many profiles can reach production. An agent may inspect environment variables, local files, CLI configuration, cached SSO sessions, SSH agents or browser state. UI permission prompts can be disabled.

## Decision
Run coding agents in isolated workspaces with no mount or forwarding of production-capable credential stores, profiles, browser sessions, SSH agents, Docker sockets or host administrative interfaces. Use a separate, short-lived, task-scoped identity only for explicitly approved non-production actions. Production access remains unavailable to the coding-agent process.

## Consequences and alternatives
Engineers retain fast code/test/preview workflows; production diagnostics use sanitized telemetry or a separate human-controlled read-only path. Endpoint/runtime engineering is required. A local prompt setting is not enforcement. Reject relying on prompt confirmation, developer discipline or inherited AWS SSO.

## Verification
Attempt reads of known credential locations and direct production API calls from the agent runtime. Both must be denied and generate attributable security events.
