# Reference architecture — AI-assisted secure engineering

## Design principle
Keep engineering accountability, coding-agent execution, CI/CD authorization and production workloads in distinct but connected trust domains. Use the smallest enforceable control set that satisfies security, performance, availability and operational requirements.

## Logical architecture

~~~mermaid
flowchart TB
  subgraph ENGINEERING["A. Engineering accountability"]
    OWNER["Service owner / senior engineer"]
    REVIEW["Named reviewer / production approver"]
  end
  subgraph AGENT["B. Coding-agent execution domain"]
    HOST["Available coding-agent host"]
    CONTEXT["Task-scoped context and source evidence"]
    TOOLS["Approved tools / integrations"]
    WORKSPACE["Isolated workspace and branch"]
    HOST <--> CONTEXT
    HOST <--> TOOLS
    HOST --> WORKSPACE
  end
  subgraph DELIVERY["C. Source and delivery control plane"]
    SCM["GitHub monorepo"]
    CI["Untrusted PR validation"]
    CHECKS["Tests, security, performance and policy checks"]
    ART["Immutable artifact + provenance"]
    APPROVAL["Protected environment + exact-change approval"]
    ID["Short-lived federated identity"]
    DEPLOY["Protected deployment"]
    SCM --> CI --> CHECKS --> ART --> APPROVAL --> ID --> DEPLOY
  end
  subgraph PLATFORM["D. Application and infrastructure"]
    CLOUD["AWS / GCP / k0s / Firebase"]
    APP["Services, APIs, databases, queues and storage"]
    AI["Production claim / document / FWA workloads"]
    CLOUD --> APP
    CLOUD --> AI
  end
  subgraph OPS["E. Observability and recovery"]
    TELEMETRY["Metrics, logs, traces and audit"]
    RESPONSE["Owned alerts, incident response and recovery"]
    TELEMETRY --> RESPONSE
  end
  OWNER --> HOST
  WORKSPACE --> SCM
  REVIEW --> APPROVAL
  DEPLOY --> CLOUD
  APP --> TELEMETRY
  AI --> TELEMETRY
  TELEMETRY --> OWNER
~~~

The diagram is logical. Exact network topology, service placement, account/project structure and deployment mechanisms must be discovered; they are not inferred from the employer's technology list.

## Trust domains

### Coding-agent execution
The coding agent receives only the task context and workspace/tool capabilities required for the current work. It must not inherit production-capable developer credentials, unrestricted host mounts or direct production mutation rights. Local sandboxing and remote tool permissions are separate capability surfaces.

### Source and delivery
Source control and CI/CD independently enforce branch protections, workflow permissions, required checks, artifact provenance, environment approval and cloud federation. A prompt or local setting cannot override these controls.

### Application and production AI
Production AI workloads use workload identities and application authorization. Developer coding-agent identities are never reused for claim/document/FWA data access. Uploaded content is untrusted; tenant/resource/action authorization is checked at each data and tool boundary.

### Operations
Runtime telemetry is correlated to source, artifact, approval and deployment identity. Incident response has named owners and tested stop, revoke, rollback, restore and failover procedures.

## Platform mapping from the scenario

| Platform | Stated role | Design boundary |
|---|---|---|
| AWS | Primary cloud; Lambda, ECS, EC2, Aurora, S3, SNS/SQS, Step Functions, CloudWatch | Workload-specific IAM, network/data controls, audit and service health |
| GCP | Vertex AI / Gemini workloads | Separate inference, data and infrastructure identities; resource-level permissions |
| k0s | Production AI agents and internal services | Workload service accounts, RBAC, admission, NetworkPolicy and cluster operations |
| Firebase Hosting | Web frontend | Isolated preview/production projects and backend resources |
| Pulumi | Existing IaC | Preserve stack/state ownership and protect preview/update paths |
| Serverless Framework | Serverless application lifecycle | Preserve service/CloudFormation stack ownership |

Exact mapping between every application component and hosting platform is not specified. Discover before changing.

## Human approval boundary
Every production change requires a named human reviewer/approver. Bind approval to exact commit SHA, checks, artifact digest or IaC plan, target environment and deployment identity. Material input changes invalidate the approval. A second approver for high-risk IAM/network/data changes is a recommended control, not an employer-stated baseline requirement.

## Architecture trade-offs

| Option | Benefit | Cost/risk | Decision |
|---|---|---|---|
| Isolated local/managed workspace | Low workflow disruption with reduced credential exposure | Endpoint isolation and policy consistency must be verified | Baseline |
| Ephemeral remote workspace | Stronger central control and clean execution boundary | Platform cost, latency and developer friction | Use for high-risk/unmanaged contexts if justified |
| Custom policy gateway for every tool call | Centralized mediation | New availability, latency and operational dependency | Add only for a measured enforcement gap |
| Agent inherits developer production SSO | Fast but broad access | Ambient authority and bypass risk | Reject |
| Replace Pulumi/Serverless with another IaC tool | Potential standardization | Unnecessary migration and state ownership risk | Reject absent explicit platform decision |

Prefer existing controls when they meet the requirement. Add a new service only when it closes a demonstrated gap and the team can account for its latency, availability, cost and ongoing ownership.
