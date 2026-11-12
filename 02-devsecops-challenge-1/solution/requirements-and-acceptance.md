# Requirements and acceptance

## Problem statement
Papaya wants engineers to work agent-first with Claude Code, including code, Git and infrastructure workflows. The current model exposes the organization because developer sessions may inherit AWS SSO profiles that can reach production, permission prompts may be disabled, plugins/MCP are unreviewed, CI contains long-lived credentials, and production approvals/monitoring are informal.

The target is not to prevent agents from being useful. It is to let them do bounded development work quickly while moving privileged authorization to independently controlled systems.

## Explicit employer requirements

| ID | Source requirement | Design response | Acceptance evidence |
|---|---|---|---|
| E-01 | Use a coding agent to complete the challenge | Conduct a genuine Codex coding-agent session | Complete raw, unedited native session/export |
| E-02 | Design framework/workflow for coding agents in DevSecOps | Provide operating model, threat model, architecture, policies, CI/CD, cloud/data controls and operations | Navigable design with workflow and control-to-test traceability |
| E-03 | Candidate has no access to Papaya systems and does not need it | Use written scenario only; label assumptions and unknowns | No claim of Papaya access or implementation |
| E-04 | Submit everything in one GitHub repository | Put both assessment parts and all used coding-agent transcripts in one repo | Repository readback and reviewer access |
| E-05 | Include complete, raw, unedited conversations for every coding-agent session used | Preserve native files/exports and reconcile every session | Session manifest matches raw files; no reconstructed summaries |
| E-06 | Submit one repository link | Prepare one reviewer-accessible URL | Owner-authorized submission |

A missing coding-agent conversation automatically fails the submission. This is a hard gate.

## Scenario-derived design requirements

| ID | Scenario fact/risk | Required design outcome |
|---|---|---|
| D-01 | Claude Code runs on laptops with AWS SSO; most profiles can reach production | Agent cannot read/use production-capable developer credentials |
| D-02 | Permission prompts may be disabled | Security is enforced outside model prompts and UI approval dialogs |
| D-03 | MCP/plugins are installed without review | Curated, owned, versioned and revocable tool marketplace |
| D-04 | GitHub Actions uses long-lived tokens and AWS keys | Remove/rotate static credentials; use minimum token scopes and federation |
| D-05 | Human approval is required for every production change | Protected deployment requires named human approval bound to exact change |
| D-06 | Monitoring is fragmented and on-call informal | Correlated audit/alerting with named owners and incident playbook |
| D-07 | One monorepo contains application and IaC domains | Change-aware CI without security-check gaps across shared dependencies |
| D-08 | AWS, GCP, k0s and Firebase have different responsibilities | Explicit provider/runtime identity boundaries |
| D-09 | Production AI agents read partner/member documents | Treat uploaded/OCR content as untrusted; enforce tenant/data authorization outside prompts |
| D-10 | Multiple insurer tenants/countries/contracts | Tenant context and jurisdiction/contract constraints follow data through every access path |

See [the control-to-enforcement matrix](control-to-enforcement-matrix.md) for the owner, enforcement point, proposed acceptance test and evidence to collect for each D requirement.

## Acceptance test suite

The design defines **32 proposed acceptance tests, AT-01 through AT-32**, listed in [rollout and assurance](rollout-and-assurance.md) and traced through the [control-to-enforcement matrix](control-to-enforcement-matrix.md). AT-32 checks that developer coding agents and production-AI workloads cannot access each other's data or tools, including rejection of unlisted workload capabilities, tenant-context substitution and disallowed provider/region routes. These are proposed Papaya acceptance tests; they have not been executed by the candidate.

## Desired outcomes
1. A developer can ask the coding agent specified by Papaya to understand code, edit source, run approved tests, prepare IaC changes and open a PR without receiving production authority.
2. Engineers retain fast, auditable diagnostics and non-production workflows.
3. Unreviewed plugins/MCP cannot silently expand tool or data access.
4. CI rejects unsafe source, dependency, image, IaC or workflow changes.
5. Only a protected deployment identity can mutate production, after a named human reviewed and approved the exact change.
6. An incident can be traced from task/session through tools, GitHub, CI, deployment and cloud events.
7. Production AI agents remain isolated from developer coding-agent identities and constrained to authorized tenant data.

## Scope boundaries and assumptions
- This is a reference design, not a production implementation.
- Exact AWS account layout, GCP project layout, network topology, Pulumi state backends, k0s topology, repository path structure, IAM policies and legal applicability are unknown.
- HIPAA and regional privacy obligations require applicability analysis by qualified legal/privacy owners; the scenario does not establish exact entity roles, data flows or contractual terms.
- Recommendations are not claims about controls already deployed at Papaya.
- No candidate lab, practice environment, synthetic cloud or demo deployment is required or built for this submission. Proposed tests describe what Papaya would validate in its own environment.

## Definition of done
- Every explicit employer requirement E-01 through E-06 maps to evidence.
- Scenario-derived requirements D-01 through D-10 map to a control, enforcement point, owner, proposed test and evidence to collect.
- Coding agents are distinguished from production AI agents.
- Design matches stated AWS/GCP/k0s/Firebase and Pulumi/Serverless context.
- No Terraform migration or custom platform is proposed without a decision trigger.
- Assumptions, trade-offs, unknowns and residual risks are visible.
- Performance, developer throughput, reliability, HA/DR, restore/failover and operations have measurable acceptance methods without invented targets.
- Codex configuration and session evidence are read back from the final repository; native session export gate is satisfied.
