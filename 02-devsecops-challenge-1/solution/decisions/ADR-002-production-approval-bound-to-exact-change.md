# ADR-002: Named human approval bound to the exact production change

- Status: Proposed; named human approval is explicit in the employer scenario
- Decision owner: Engineering release owner + Compliance/Security policy owner
- Date: 2026-11-12

## Context
Compliance requires every production change, human- or agent-originated, to have a named human reviewer/approver. Review can become stale if the branch changes after approval.

## Decision
Production deployment is permitted only through a protected environment/workflow after required checks and named human approval. The approval record binds repository, PR, exact commit SHA, artifact digest, IaC preview/plan reference, target environment, deployment identity, approver and timestamp. Any source, artifact or plan change invalidates approval and requires review again.

## Enforcement
GitHub protected branch/environment rules, independent CODEOWNERS review for privileged paths, job-level OIDC permission, cloud trust conditions and IAM permissions. The cloud role is unavailable to local coding-agent sessions.

## Consequences and alternatives
Production deployment is more controlled; low-risk local and non-production work remains fast. Reject approval tied only to a ticket/branch name, model self-approval or a local agent session. A second approver is a risk-based enhancement for IAM, network, data and security-policy changes, not the baseline requirement.

## Verification
Change the commit after approval, attempt direct cloud deployment from the agent and attempt deployment from an unapproved ref. Each must be denied.
