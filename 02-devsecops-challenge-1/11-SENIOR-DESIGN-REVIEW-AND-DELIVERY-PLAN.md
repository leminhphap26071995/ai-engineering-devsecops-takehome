# 11. Strong Senior DevSecOps Design Review and Delivery Plan

## Executive recommendation
Use the existing Claude Code + GitHub monorepo + GitHub Actions + Pulumi/Serverless operating model, but place explicit trust boundaries around the developer agent and production deployment.

The smallest effective target state has five control groups:
1. **Developer endpoint:** Claude Code managed policy, isolated workspace, no production credentials, approved tool/plugin set.
2. **Source control:** protected monorepo paths, CODEOWNERS, required PR review and complete change traceability.
3. **CI/CD:** minimal workflow permissions, no long-lived cloud keys, OIDC/WIF, exact-SHA checks and immutable artifacts.
4. **Production authorization:** named human approval for every production change; cloud IAM prevents direct agent bypass.
5. **Operations/data protection:** correlated audit, named incident owners, tenant enforcement and provider/data governance.

Do not begin by building a custom agent gateway, replacing IaC, or deploying a new cross-cloud platform. First close the concrete exposures in the scenario.

## Corrections to the previous baseline

| Previous weakness | Correction |
|---|---|
| Treated the design as broadly tool-agnostic | Anchor target controls in Claude Code, the tool Papaya actually names |
| Conflated coding agents and production AI agents | Separate developer coding-agent and production workload trust domains |
| Overemphasized a generic multi-cloud abstraction/Terraform | Preserve Pulumi + Serverless; Terraform is conditional and not needed to satisfy the brief |
| Generic cloud controls without mapping stated platform | Map AWS services, GCP Vertex/Gemini, k0s and Firebase Hosting to their boundaries |
| Monorepo implications not concrete | Add dependency-aware checks, CODEOWNERS and privileged workflow protection |
| Firebase preview risk underplayed | Isolate preview backend/data; preview channels may use real project resources |
| Compliance labels too general | Distinguish Team Premium from HIPAA-ready Enterprise/BAA feature scope; default to no PHI in coding-agent sessions |
| Risk of overengineering | Prefer existing product controls and cloud-native authorization before custom brokers |

## Practical response to the Engineering vs Compliance conflict

| Engineering need | Safe capability | Boundary |
|---|---|---|
| Understand production issue | Read sanitized telemetry and approved read-only diagnostics | No raw claim data or broad production shell |
| Author infrastructure fix | Edit Pulumi/Serverless code and run local checks/preview | No production state administration or apply credential |
| Validate quickly | Automated CI, IaC preview, policy tests and staging deploy | Untrusted PR receives no privileged secrets |
| Ship infrastructure | Protected deploy workflow with short-lived identity | Named human approval bound to exact commit and preview |
| Emergency intervention | Human break-glass path with time-bound access and audit | Agent never receives break-glass credential |

This gives engineers a fast route to propose, test and prepare a change. It does not give a coding agent unrestricted production access.

## Recommended rollout

### First 2 weeks — contain and standardize
- Inventory AWS SSO permission sets and identify developer profiles that can reach production.
- Remove production profiles/caches from agent execution contexts; separate normal development access from emergency human access.
- Inventory and rotate long-lived GitHub/AWS credentials in repository secrets.
- Inventory current Claude Code versions, settings, plugin/MCP installs and data handling.
- Establish named production approval and protect existing deployment path.
- Identify owners for GitHub Actions, Pulumi, Serverless, k0s, Firebase and cloud identities.

### Weeks 3–6 — secure the engineering path
- Roll out managed Claude Code settings and endpoint/runtime isolation.
- Curate internal plugins/MCP; pin releases, review permissions and add emergency revocation.
- Harden monorepo CI and privileged workflow paths.
- Replace static cloud credentials with AWS OIDC and GCP WIF.
- Add Pulumi/Serverless preview, policy and approval gates.
- Isolate Firebase preview resources from production backends.
- Centralize key audit events and assign on-call ownership.

### Weeks 7–12 — extend assurance to production AI workloads
- Map production claim/document/FWA agent data flows and tenant enforcement.
- Add cross-tenant, indirect prompt-injection, unsafe-output and queue-replay tests.
- Validate model/provider retention, region, subprocessor and contractual constraints.
- Exercise kill switch, credential revocation, rollback and incident notification paths.
- Review control metrics and tune developer friction without weakening authorization.

These time ranges are a planning proposal; actual sequencing depends on staffing, platform inventory and business criticality.

## Design alternatives and trade-offs

| Option | Benefit | Cost/risk | Recommendation |
|---|---|---|---|
| Managed local Claude Code + isolated dev workspace | Lowest workflow disruption; directly matches scenario | Requires endpoint management and credential separation | **Preferred baseline** |
| Remote ephemeral devbox for all agent work | Stronger isolation and centralized control | More platform cost and developer friction | Use for higher-risk tasks or unmanaged endpoints |
| Custom MCP/policy gateway first | Centralized policy point | New service, availability, auth, schema and operational burden | Defer until measured gap justifies it |
| Agent receives developer AWS SSO and production role | Fast initial debugging | Credential inheritance and production bypass | Reject |
| Replace Pulumi with Terraform | One IaC tool if migration is strategic | Not required; state migration and ownership risk | Reject for take-home scope |

## Operating metrics
Establish baseline, then set targets with service owners:
- Agent sessions linked to approved task/repository.
- Percentage of agent sessions without production-capable credentials.
- Approved plugin/MCP coverage and time to revoke compromised release.
- Long-lived GitHub/cloud credential count.
- Production changes with named approval on exact SHA/plan.
- CI security coverage across affected monorepo components.
- Cross-tenant negative-test coverage.
- Time to stop agent, revoke identity and contain incident.
- Developer cycle time and approval latency, ensuring controls do not make safe work unusable.

## Control-to-evidence acceptance
For each high-risk control, retain:

Scenario → Risk → Policy → Enforcement Point → Negative Test → Observed Result → Owner

A policy statement without an enforcement point and falsifiable test is only a design assertion. Tests in [Rollout and Acceptance](08-ROLLOUT-AND-ACCEPTANCE.md) are proposed; none has been run against Papaya systems.

## Key external references
- [Claude Code settings and precedence](https://code.claude.com/docs/en/settings)
- [Anthropic Claude Code sandboxing](https://www.anthropic.com/research/claude-code-sandboxing)
- [Claude Code CLI plugin marketplaces and managed restrictions](https://code.claude.com/docs/en/plugin-marketplaces)
- [GitHub Actions deployment security and OIDC](https://docs.github.com/en/actions/how-tos/secure-your-work/security-harden-deployments)
- [AWS temporary elevated access](https://docs.aws.amazon.com/singlesignon/latest/userguide/temporary-elevated-access.html)
- [Firebase Hosting PR previews](https://firebase.google.com/docs/hosting/github-integration)
- [OWASP GenAI LLM Top 10 2026](https://github.com/GenAI-Security-Project/GenAI-LLM-Top10/tree/main/2026)
- [NIST AI RMF Generative AI Profile](https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence)

## Limitations
This is a source-based candidate design, not a Papaya security assessment or implementation. No Papaya environment, code, cloud account, IAM configuration or production data was accessed.
