# DevSecOps Challenge 1 — Claude Code Governance and Secure Delivery Design

> Candidate reference design based on the employer's written scenario. No Papaya systems were accessed or implemented.

## Executive summary
The challenge asks for a practical framework and workflow that lets Papaya engineers use Claude Code productively without allowing agent sessions or developer credentials to bypass security and human production approval.

**Recommended approach:** secure the existing developer → GitHub monorepo → GitHub Actions → Pulumi/Serverless → AWS/GCP/k0s/Firebase path. Do not add a new agent platform or replace IaC unless discovery proves a concrete need.

## Documents
- [Source intent and design decisions](00-SOURCE-INTENT-AND-DECISIONS.md)
- [Problem, requirements and acceptance](01-PROBLEM-AND-REQUIREMENTS.md)
- [Threat model](02-THREAT-MODEL.md)
- [Reference architecture](03-REFERENCE-ARCHITECTURE.md)
- [Claude Code and tool security policy](04-AGENT-SECURITY-POLICY.md)
- [Monorepo CI/CD and production workflow](05-CICD-AND-PRODUCTION-WORKFLOW.md)
- [Cloud, runtime and insurance data protection](06-CLOUD-AND-DATA-PROTECTION.md)
- [Operations and incident response](07-OPERATIONS-AND-INCIDENT-RESPONSE.md)
- [Rollout plan and acceptance tests](08-ROLLOUT-AND-ACCEPTANCE.md)
- [Residual risks and open decisions](09-RESIDUAL-RISKS.md)
- [Multi-cloud IaC strategy](10-MULTICLOUD-IAC-STRATEGY.md)
- [Strong Senior design review and delivery plan](11-SENIOR-DESIGN-REVIEW-AND-DELIVERY-PLAN.md)

## Source-aligned platform context
- AWS primary: Lambda/Serverless Framework, ECS, EC2, Aurora PostgreSQL, SNS, SQS, Step Functions, S3 and CloudWatch.
- GCP: Vertex AI and Gemini API workloads.
- k0s: production AI agents and internal services.
- Firebase Hosting: web frontends.
- Engineering: one GitHub monorepo; Pulumi and Serverless Framework; GitHub Actions; Claude Code Team Premium and internal plugin marketplace; Linear and Slack.
- Data: insurance claims, medical, diagnosis, member identity and bank-account information across insurer tenants/countries.

These are employer-stated scenario facts. Exact topology, account layout, IAM, repository paths, IaC state and legal applicability remain unknown.

## Critical distinction
The developer coding agent (Claude Code) and production AI agents (claim assessment, document extraction/classification, FWA) are separate workloads. They must not share identities, credentials, data access or runtime trust.

## Evidence gate
- A genuine coding-agent session is still required.
- Every session used for the challenge must be preserved as a complete, raw, unedited native transcript/export.
- Proposed acceptance tests have not been executed against Papaya.
- Owner review and final repository submission remain pending.
