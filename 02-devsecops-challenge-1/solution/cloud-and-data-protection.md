# Cloud and data protection

## AWS

- Use workload identity federation and short-lived role sessions.
- Separate agent, CI validation/plan, staging deploy and production deploy roles.
- Scope IAM by repository/workflow/environment claims and resource boundaries.
- Keep production secrets in managed stores; never inject them into coding-agent context.
- Use CloudTrail and service audit logs for attributable activity.
- Apply private networking and egress restrictions where feasible.
- Protect S3 claim documents with private access, encryption, tenant-aware authorization, access logging and retention controls.

## GCP

- Use Workload Identity Federation for GitHub CI and supported external workloads; avoid distributing service-account key files.
- Separate Vertex AI/Gemini inference permissions from claim-data access and infrastructure administration.
- Scope service accounts to minimum project/model/resource access.
- Enforce organization policies, audit IAM and data access, and restrict service-account key creation/upload.
- Review model/data location, retention, logging and subprocessors for each approved use case.

## Kubernetes / k0s

- Separate namespaces and service accounts by workload/environment and, where required, tenant boundary.
- Apply RBAC least privilege, Pod Security Standards, network policies and quotas.
- Do not mount host paths, Docker sockets or cluster-admin credentials into coding-agent pods.
- Use admission policy to block privileged workloads, host namespaces and untrusted images.
- Store secrets outside source and inject only into approved runtime workloads.
- Use signed/pinned images, image provenance and Kubernetes audit logging.
- Test service-account token permissions and cloud workload identity mapping.

## Multi-cloud IaC and state

- Preserve Pulumi and Serverless Framework as current owners of resources they already manage.
- Terraform is conditional for explicitly scoped AWS/GCP foundations; it must not duplicate existing Pulumi/Serverless ownership.
- Separate AWS and GCP state, accounts/projects and environment trust boundaries.
- Use encrypted remote state, least-privilege backend access, locking, versioning and audit.
- Treat Terraform state and plan artifacts as sensitive; redact display is not equivalent to omitting a value from state.
- Use distinct plan and apply identities, short-lived OIDC/WIF credentials and protected production approvals.
- See [Multi-cloud IaC Strategy](infrastructure-ownership.md).

## Data and tenant protection

- Classify claims, medical, identity, member, partner and financial data.
- Use synthetic fixtures for development and tests.
- Route agent access through existing application APIs or equivalent service boundaries that authorize task identity, tenant, resource and action; do not expose broad direct DB/object-store/queue credentials to the model or agent.
- Enforce tenant scoping in APIs, GraphQL resolvers, database queries, object storage, queues, caches, retrieval pipelines and analytics. Add vector-store controls only where such a store is actually present.
- Apply encryption in transit/at rest, retention controls and audited access.
- Prevent sensitive records from entering prompts, issue comments, CI logs or agent transcripts.
- Review cross-border processing, subprocessors and provider retention per jurisdiction/contract.
- Correlate data access with tenant, actor/workload identity, purpose and approved task without logging unnecessary payloads.

## Compliance boundary

ISO/IEC 27001, HIPAA and local privacy laws require scope-specific interpretation and evidence. This proposal maps engineering controls to objectives; it does not establish legal applicability, certification or compliance. Legal/privacy owners must confirm obligations for Vietnam, Thailand, Hong Kong and each insurer/partner contract, including controller/processor roles, lawful basis, cross-border transfers, retention and incident notification duties.
