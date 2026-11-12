# Problem, scope and design intent

## Source lock
- Employer source: [DevSecOps Challenge 1](https://github.com/papaya-insurtech/pumpkin/blob/main/Hiring/DevSecOps_Challenges/DevSecOps_Challenge_1.md)
- Reviewed source blob on main: 4eae49e24c9ba3c59102c0149b70b601d830002a.
- Scope: the complete challenge, including Appendix A — Papaya Platform Context.
- The source asks candidates to design a framework and workflow for how Papaya uses coding agents for DevSecOps. It explicitly says the candidate has no access to Papaya systems and does not need it.

## What the employer is actually asking
This is a secure engineering operating-model problem, not a request to build a new AI platform.

Papaya has adopted an approach in which developers use coding agents as part of their day-to-day engineering work. The design must make that productive direction safe across developer workstations, source control, CI/CD, cloud infrastructure and production change approval.

The central conflict is explicit:
- Engineering wants agents to help debug and ship infrastructure without unnecessary waiting.
- Compliance requires every production change — whether initiated by a human or an agent — to have a named human who reviewed and approved it.

Preserve fast, low-risk engineering work while ensuring neither a model nor broad workstation credentials can bypass production controls.

## Root cause — why the current model is unsafe

The failure is architectural, not simply a matter of careless prompting:

1. **Identity inheritance:** the coding agent runs inside a developer workstation session that already has AWS SSO credentials and production-capable profiles. The agent can therefore exercise authority granted to the human for a different purpose.
2. **Prompt/UI as a false boundary:** disabling permission prompts removes an interaction check, but enabling prompts still cannot stop a process that can read credentials or call cloud APIs directly.
3. **Uncontrolled capability expansion:** unreviewed MCP servers and plugins can add executable tools, filesystem/network reach and external data paths without a consistent owner, provenance or revocation process.
4. **Privileged CI credentials:** long-lived GitHub/AWS secrets let untrusted or compromised workflow execution inherit durable authority.
5. **Approval is not bound to execution:** informal approval can be bypassed if the deploy identity remains reachable directly, or if approval is not tied to the exact commit, artifact and plan.
6. **Fragmented detection and response:** incomplete correlation and informal on-call make agent-driven incidents difficult to identify, stop and investigate.
7. **A separate data-plane risk:** production AI agents process untrusted partner/member documents across insurer tenants; prompt injection, over-broad service identities or missing tenant checks can expose sensitive data even when developer coding agents are secured.

The common problem is **ambient authority**: a process inherits permissions broader than its task requires, instead of receiving access only to the specific resource and action it needs for a limited time.

## Recommended approach

Give each coding agent only the access its task requires, keep production approval independent, and record evidence for every change:
- Let the coding agent read the assigned repository, edit a scoped workspace, run approved local checks and prepare a PR.
- Remove production-capable credentials and host credential stores from its execution context.
- Mediate MCP/plugin capabilities through a reviewed, versioned and revocable tool supply chain.
- Keep untrusted PR validation separate from privileged CI; use short-lived AWS OIDC and GCP Workload Identity Federation only inside protected deployment jobs.
- Require a named human to approve every production change, with approval bound to the exact commit, artifact/plan and target environment; enforce the same boundary in cloud IAM.
- Keep production AI agents on separate workload identities and enforce tenant/resource/action authorization outside model prompts at every data access and side effect.
- Keep a trace from the task and agent session through tool calls, PR, commit, CI, approval and deployment. Test that the team can stop the agent, revoke its credentials and roll back a change.

## Source facts versus design choices

| Classification | Statement |
|---|---|
| Employer-stated fact | Claude Code (Team Premium) is the primary coding agent for engineers. |
| Employer-stated fact | Engineers run Claude Code on laptops signed in to AWS through SSO; most profiles can reach production. |
| Employer-stated fact | Some engineers disable permission prompts. |
| Employer-stated fact | MCP servers/plugins are installed without a review process. |
| Employer-stated fact | GitHub Actions includes long-lived GitHub tokens and AWS access keys in repository secrets. |
| Employer-stated fact | Monitoring is fragmented across CloudWatch, GCP and Slack; on-call is informal. |
| Employer-stated fact | Backend uses Node.js/TypeScript, GraphQL (Apollo Server, Hasura) and PostgreSQL; frontend/mobile use Next.js, React and React Native/Expo; AI/ML uses Python, PyTorch, OpenAI, Vertex AI, Gemini and Claude. |
| Employer-stated fact | One GitHub monorepo contains apps, web, backend, mobile, AI/ML and IaC. |
| Employer-stated fact | Pulumi is used for IaC; Serverless Framework is used for Lambda functions. |
| Employer-stated fact | AWS is primary; GCP hosts Vertex AI/Gemini workloads; k0s hosts AI agents/internal services; Firebase Hosting serves web frontends. |
| Employer-stated fact | Production AI agents read partner/member-uploaded documents for claim assessment, extraction/classification and FWA detection. |
| Employer-stated fact | Multiple insurer tenants operate across countries and have different data and contractual requirements. |
| Design recommendation | Remove production credentials from coding-agent execution; use isolated workspaces and scoped non-production/diagnostic access. |
| Design recommendation | Use managed Claude Code policy where available, OS/runtime isolation, a curated plugin marketplace and external authorization. |
| Design recommendation | Keep production deployment in protected GitHub Actions/cloud paths with named human approval. |
| Design recommendation | Keep Pulumi and Serverless Framework as default IaC owners; Terraform is not required by this challenge. |

## Two different kinds of agents — do not conflate them

### A. Developer coding agents
The challenge primarily concerns Claude Code running on developer laptops. It can inspect source, edit code, run commands, use MCP/plugins, interact with Git and help author infrastructure changes. Main risks are inherited developer credentials, unsafe local execution, untrusted repository content, tool/plugin supply chain, CI privilege escalation and production bypass.

### B. Production AI agents
Appendix A separately describes production agents for claims, document extraction/classification and FWA. They read untrusted documents and operate within an insurance data platform. Principal risks include indirect prompt injection, excessive data access, cross-tenant leakage, unsafe outputs, model/provider data handling and consequential automated decisions.

These are different workloads with different identities, runtimes, data and authorization. Coding agents must not inherit production-agent identities; production agents must not inherit developer Claude Code permissions. Threats intersect, but controls are not interchangeable.

## Design decisions
1. Claude Code is the reference developer-agent runtime because Appendix A names it as Papaya's standard. Cursor/Codex may be valid candidate tools for the mandatory assessment session, but do not replace the proposed design for Papaya.
2. No production cloud credentials in the coding-agent context. Engineers retain fast code inspection, local tests, infrastructure preview and scoped diagnostics. Production mutation remains in protected deployment workflows.
3. Production approval applies equally to human- and agent-originated changes. The minimum scenario requirement is a named human reviewer/approver. A second independent approver for high-risk changes is a recommended enhancement, not an explicit employer requirement.
4. Preserve existing IaC ownership. Pulumi remains the stated infrastructure tool; Serverless Framework owns its Lambda service/CloudFormation lifecycle. Do not add Terraform merely because AWS and GCP both exist.
5. Use the existing GitHub monorepo as the control point. Do not propose repository migration or a new deployment platform without evidence.
6. Prefer existing enforceable controls over custom platform components. Start with Claude Code managed policy, endpoint/runtime isolation, IAM, GitHub protections, CI and existing IaC engines. Introduce a custom policy broker only if a concrete enforcement gap remains.
7. Do not send real claims/medical/member/financial data to coding-agent sessions. Use synthetic or sanitized fixtures. Verify provider contractual/regulatory eligibility before any production-data processing.

## Non-goals
- Implementing or auditing Papaya infrastructure.
- Building a new agent platform, MCP gateway or cross-cloud abstraction as part of the take-home.
- Replacing Pulumi with Terraform.
- Redesigning production AI/ML business logic.
- Claiming ISO 27001 conformity, HIPAA compliance/certification or legal compliance.
- Deploying real cloud resources or using production credentials.
