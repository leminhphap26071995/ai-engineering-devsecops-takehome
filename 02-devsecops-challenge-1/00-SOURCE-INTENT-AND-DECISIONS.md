# 0. Source Intent, Scope and Design Decisions

## Source lock
- Employer source: [DevSecOps Challenge 1](https://github.com/papaya-insurtech/pumpkin/blob/main/Hiring/DevSecOps_Challenges/DevSecOps_Challenge_1.md)
- Reviewed source blob on main: 4eae49e24c9ba3c59102c0149b70b601d830002a.
- Scope: the complete challenge, including Appendix A — Papaya Platform Context.
- The source asks candidates to design a framework and workflow for how Papaya uses coding agents for DevSecOps. It explicitly says the candidate has no access to Papaya systems and does not need it.

## What the employer is actually asking
This is a secure engineering operating-model problem, not a request to build a new AI platform.

Papaya has adopted an agent-first engineering direction. The design must make that productive direction safe across developer workstations, source control, CI/CD, cloud infrastructure and production change approval.

The central conflict is explicit:
- Engineering wants agents to help debug and ship infrastructure without unnecessary waiting.
- Compliance requires every production change — whether initiated by a human or an agent — to have a named human who reviewed and approved it.

Preserve fast, low-risk engineering work while ensuring neither a model nor broad workstation credentials can bypass production controls.

## Source facts versus design choices

| Classification | Statement |
|---|---|
| Employer-stated fact | Claude Code (Team Premium) is the primary coding agent for engineers. |
| Employer-stated fact | Engineers run Claude Code on laptops signed in to AWS through SSO; most profiles can reach production. |
| Employer-stated fact | Some engineers disable permission prompts. |
| Employer-stated fact | MCP servers/plugins are installed without a review process. |
| Employer-stated fact | GitHub Actions includes long-lived GitHub tokens and AWS access keys in repository secrets. |
| Employer-stated fact | Monitoring is fragmented across CloudWatch, GCP and Slack; on-call is informal. |
| Employer-stated fact | Backend uses Node.js/TypeScript, GraphQL (Apollo Server, Hasura) and PostgreSQL; frontend/mobile use Next.js, React and React Native/Expo; AI/ML uses Python, PyTorch, OpenAI, Vertex AI, Gemini and Claude. |\n| Employer-stated fact | One GitHub monorepo contains apps, web, backend, mobile, AI/ML and IaC. |
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
The challenge primarily concerns Claude Code running on developer laptops. It can inspect source, edit code, run commands, use MCP/plugins, interact with Git and help author infrastructure changes. Principal risks are inherited developer credentials, unsafe local execution, untrusted repository content, tool/plugin supply chain, CI privilege escalation and production bypass.

### B. Production AI agents
Appendix A separately describes production agents for claims, document extraction/classification and FWA. They read untrusted documents and operate within an insurance data platform. Principal risks include indirect prompt injection, excessive data access, cross-tenant leakage, unsafe outputs, model/provider data handling and consequential automated decisions.

These are different workloads with different identities, runtimes, data and authorization. Coding agents must not inherit production-agent identities; production agents must not inherit developer Claude Code permissions. Threats intersect, but controls are not interchangeable.

## Design decisions
1. Claude Code is the reference developer-agent runtime because Appendix A names it as Papaya's standard. Cursor/Codex may be valid candidate tools for the mandatory assessment session, but do not replace the Papaya target-state design.
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
