# 3. Reference Architecture

## Design principle
Keep developer coding-agent workflow, CI/CD control plane and production AI-agent workloads as separate trust domains. Reuse the existing platform; add the smallest set of controls that closes the stated risks.

## Logical architecture

~~~mermaid
flowchart TB
  subgraph DEV["A. Developer workstation / coding-agent domain"]
    ENG["Engineer + approved task"]
    CC["Claude Code (Team Premium scenario)"]
    POLICY["Managed settings / permission policy"]
    SANDBOX["Isolated workspace + OS sandbox"]
    PLUGINS["Curated internal plugin marketplace"]
    DIAG["Scoped non-production / sanitized diagnostics"]
    ENG --> CC
    POLICY --> CC
    CC --> SANDBOX
    CC <--> PLUGINS
    SANDBOX --> DIAG
  end
  subgraph SCM["B. Source and CI/CD control domain"]
    MONO["GitHub monorepo"]
    PR["Branch + Pull Request"]
    CHECKS["Monorepo-aware CI checks"]
    REVIEW["Named human review"]
    ENV["Protected deployment environment"]
    FED["Short-lived OIDC / WIF identity"]
    MONO --> PR --> CHECKS --> REVIEW --> ENV --> FED
  end
  subgraph CLOUD["C. Infrastructure and application platform"]
    AWS["AWS primary: Lambda, ECS, EC2, Aurora, S3, SNS/SQS, Step Functions, CloudWatch"]
    GCP["GCP: Vertex AI / Gemini"]
    K0S["k0s: production AI agents + internal services"]
    FIREBASE["Firebase Hosting: web frontend"]
  end
  subgraph PRODAGENT["D. Production AI-agent domain (not the coding agent)"]
    AGENT["Claim assessment / document AI / FWA agents"]
    INPUT["Partner/member uploads: untrusted documents"]
    DATA["Tenant-scoped application data and APIs"]
    INPUT --> AGENT
    AGENT <--> DATA
  end
  subgraph OBS["E. Security operations and evidence"]
    AUDIT["Correlated audit events"]
    ALERT["Owned alerts / on-call / incident response"]
  end
  SANDBOX --> MONO
  FED --> AWS
  FED --> GCP
  FED --> FIREBASE
  K0S --> AWS
  K0S --> GCP
  AGENT --> K0S
  AGENT --> GCP
  MONO -. session / PR / SHA .-> AUDIT
  CHECKS -. results / artifacts .-> AUDIT
  ENV -. approver / deployment .-> AUDIT
  AWS -. CloudTrail / service logs .-> AUDIT
  GCP -. Cloud Audit Logs .-> AUDIT
  K0S -. Kubernetes / workload logs .-> AUDIT
  AUDIT --> ALERT
~~~

The diagram is logical, not a claim about current Papaya network/deployment topology. Exact workload placement and service-to-service flows require discovery.

## A. Developer coding-agent domain
- Claude Code is the reference tool because Appendix A names it as Papaya's standard.
- Organization-managed settings define approved permission modes, tool policy, marketplace sources and minimum version where the plan/admin features support them.
- Run the agent in an isolated workspace or managed dev environment. Do not expose developer AWS SSO caches, production CLI profiles, SSH agents, browser sessions, Docker socket or unrelated home directories.
- Give the agent branch/workspace write access, approved local test tools and scoped non-production diagnostics.
- Keep production mutation and sensitive data access out of the coding-agent process.
- Use the internal Claude Code plugin marketplace as curated distribution, not as a substitute for security review.

## B. GitHub monorepo and CI/CD domain
- One repository contains multiple application and infrastructure domains; use path/dependency-aware checks but retain global checks for security-critical files and shared components.
- Protect workflows, IaC, IAM, plugin definitions, security policies and deployment configuration with CODEOWNERS and required reviews.
- Untrusted PR validation receives no production secrets or privileged write/id-token permissions.
- Build immutable artifacts, record source SHA and provenance, and promote the same tested artifact through environments where practical.
- Production deployment requires named human approval and a cloud identity constrained to repository, ref, workflow and environment.

## C. Application and runtime domain\n\n| Layer | Employer-stated technologies | Design implications |\n|---|---|---|\n| Backend/API | Node.js, TypeScript, GraphQL (Apollo Server, Hasura), PostgreSQL | Schema/contract checks, resolver authorization, migration validation and tenant context enforcement |\n| Web frontend | Next.js, React; Firebase Hosting | Preview isolation, frontend dependency/build checks and protected production hosting |\n| Mobile | React Native, Expo | Separate build/signing/release credentials; do not expose signing secrets to coding agents or untrusted PR jobs |\n| AI/ML | Python, PyTorch, OpenAI, Vertex AI, Gemini, Claude | Model/data pipeline checks, provider governance, workload identity and data minimization |\n| Production agents | Claim assessment, document extraction/classification, FWA; read partner/member uploads | Untrusted document input, tenant-scoped access and validated outputs; deployment/runtime placement must be confirmed |\n\nExact service-to-hosting mapping is not fully specified; do not infer that every backend or AI component runs on one particular cloud service.\n\n## C. Cloud and runtime domain

| Platform | Employer-stated responsibility | Design boundary |
|---|---|---|
| AWS (primary) | Lambda/Serverless, ECS, EC2, Aurora PostgreSQL, SNS, SQS, Step Functions, S3, CloudWatch | Workload-specific IAM roles; private claim storage; DB/queue authorization; CloudTrail/service audit |
| GCP | Vertex AI and Gemini API workloads | Separate model-inference identity from data access and infrastructure administration; approved model/data route |
| k0s | AI agents and internal services | Kubernetes service accounts/RBAC, namespace/network boundaries, admission controls and workload-specific cloud identity |
| Firebase Hosting | Web frontends | Separate preview and production projects/data; protected deploy identity; no production backend access from untrusted previews |

## D. Production AI-agent domain
Production claim/document/FWA agents are application workloads, not developer coding agents. They use service identities and application authorization, never developer AWS SSO or Claude Code credentials. Uploaded files, OCR and extracted text are untrusted data. Tenant identity is checked at every data access and downstream action.

## E. Observability and operations
Correlate task/session, tool call, GitHub PR/SHA, CI run, approval, deployment identity and cloud/runtime events. CloudWatch and GCP audit/logging remain provider-native sources; aggregate security events into an owned incident workflow. Slack is a notification channel, not authoritative audit storage.

## Human approval boundary
The employer's minimum requirement is a named human who reviewed and approved every production change, whether initiated by an agent or a person. Bind approval to exact commit, artifact and infrastructure preview/plan. A second approver for high-risk IAM, network, data and production changes is a recommended separation-of-duties control if the organization can support it.
