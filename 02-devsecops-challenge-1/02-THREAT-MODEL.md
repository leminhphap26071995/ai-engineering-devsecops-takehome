# 2. Threat Model

## Scope
Model two distinct systems: (1) developer coding-agent sessions and (2) production AI-agent workloads. Identify assets, trust boundaries, attack paths, impact, controls and negative tests. Treat Claude Code, tools and generated output as potentially fallible; authorization is decided outside the model.

## Assets
- Source code, monorepo workflows, build artifacts, release material and deployment configuration.
- Developer identities, AWS IAM Identity Center/SSO sessions, GitHub tokens, cloud roles and CI credentials.
- Pulumi state/secrets, Serverless deployment artifacts and CloudFormation stacks.
- AWS S3 claim documents, Aurora PostgreSQL data, queues/events, Step Functions and service logs.
- GCP Vertex AI/Gemini access, model request context and service identities.
- k0s cluster credentials, namespaces, service accounts, workloads and internal services.
- Firebase Hosting projects, preview channels, deployment credentials and connected backend resources.
- Insurer/partner/member data: medical, diagnosis, identity, claim history and bank-account information.
- Agent prompts, tool calls, plugin packages, MCP configuration, session transcripts and audit evidence.

## System A — developer coding-agent threats

| Threat | Attack path | Impact | Primary controls | Negative test |
|---|---|---|---|---|
| Credential inheritance | Claude Code reads AWS SSO cache, environment, CLI config, SSH agent or browser session | Production access/data exposure | Isolated workspace; no host credential mounts; separate agent identity; production role unavailable | Agent reads credential paths/calls production APIs; denied and logged |
| Permission bypass | User starts bypass/no-prompt mode or modifies local settings | Unsafe shell, filesystem or network action | Managed Claude Code policy where available; OS/runtime sandbox; IAM and repo controls | Attempt bypass and protected-path/network action; boundary still blocks |
| Indirect prompt injection | Malicious issue, PR, source comment, README, package metadata or tool output instructs agent | Secret exfiltration/tool abuse | Treat content as untrusted; authorize every tool call; restrict egress/capabilities | Seed malicious content; no secret access or unauthorized egress |
| MCP/plugin compromise | Malicious/updated plugin installed from unreviewed source | Code execution/data exfiltration | Curated marketplace, provenance review, immutable release, scope review, allowlist and revocation | Unapproved source and version drift blocked |
| Host/workspace escape | Agent abuses shell, filesystem mounts, Docker socket or local service | Host compromise/credential theft | Ephemeral dev container/VM, least-privilege OS account, filesystem/network boundaries, no privileged mounts | Host path, Docker socket and credential access denied |
| Source/PR abuse | Agent alters workflow, CODEOWNERS, branch protection or security policy | CI privilege escalation/approval bypass | Protected paths, CODEOWNERS, required review and admin-owned rules | Privileged workflow/policy PR cannot self-approve or bypass |
| CI credential abuse | Workflow exposes long-lived token/key to untrusted PR code | Repo/cloud compromise | Revoke static credentials; minimal GITHUB_TOKEN; OIDC/WIF; split untrusted validation from deploy | Fork PR has no privileged secrets/token |
| Production bypass | Agent uses developer profile or direct cloud API | Unreviewed production mutation | No production credentials in agent; protected environment; cloud-side trust | Direct agent deploy denied despite local prompt bypass |
| IaC state exposure | Agent reads Pulumi state/backend credentials/Serverless artifacts | Secret/topology disclosure | Restricted state/artifact permissions; preview role; no state-admin access | Agent state read/export denied |
| Transcript leakage | Raw session captures secrets or personal data | Evidence repository becomes exposure channel | Synthetic data; pre-session hygiene; inspect before publication | Secret fixture detected before transcript publication |

## System B — production AI-agent threats

| Threat | Attack path | Impact | Primary controls | Negative test |
|---|---|---|---|---|
| Indirect prompt injection | Uploaded PDF/image/OCR contains instructions to call tools/disclose data | Unauthorized action/data leakage | Treat documents as untrusted; separate instructions/content; tool authorization outside model | Malicious claim document requests cross-tenant export; denied |
| Cross-tenant retrieval | Query omits/tampers insurer context in DB, object, vector or queue path | Confidentiality/contract breach | Tenant authorization at API, resolver, DB, S3, queue, cache and retrieval layer | Tenant A requests Tenant B record; no data returned |
| Excessive workload identity | Production agent service account has broad cloud/cluster access | Lateral movement/bulk data access | Per-service identity, scoped permissions, network boundaries and secret isolation | Compromised agent cannot access unrelated tenant/admin API |
| Unsafe output handling | Generated SQL/GraphQL/action/claim recommendation reaches downstream unchecked | Data mutation or harmful decision | Typed schemas, validation, parameterized queries, business rules and human review for consequential outcomes | Invalid/adversarial output rejected |
| Model/provider data exposure | Sensitive content sent to unapproved provider/region | Regulatory/contractual breach | Classification, minimization, approved provider route, retention/residency review | Disallowed data class/provider combination blocked |
| Queue/workflow replay | Duplicate/tampered SNS/SQS/Step Functions event repeats action | Duplicate processing/unauthorized transition | Authenticated event source, idempotency, schema validation and state-transition authorization | Replayed event cannot duplicate consequential operation |

## Trust boundaries
1. Developer endpoint ↔ Claude Code process.
2. Claude Code ↔ filesystem, shell, network and local credentials.
3. Claude Code ↔ approved MCP/plugin tools.
4. Coding-agent workspace ↔ GitHub monorepo.
5. GitHub PR validation ↔ privileged CI/deployment workflow.
6. CI identity ↔ AWS, GCP and Firebase deployment APIs.
7. k0s workload identity ↔ AWS/GCP data/model services.
8. Application service ↔ insurer tenant data.
9. Production AI agent ↔ uploaded documents/OCR/model/tool output.
10. Audit/evidence system ↔ sensitive session/application metadata.

## Risk priorities
**P0:** inherited production credentials; static CI secrets; unreviewed plugins/MCP; missing named production approval; cross-tenant data access.

**P1:** indirect prompt injection, IaC state access, workflow privilege escalation, audit fragmentation, unsafe previews and missing incident ownership.

**P2:** model cost abuse, provider/version drift, expanded agent autonomy and advanced policy automation after baseline controls are proven.

Revisit rankings after asset, identity and data-flow inventory. This is scenario-based prioritization, not a Papaya risk assessment.
