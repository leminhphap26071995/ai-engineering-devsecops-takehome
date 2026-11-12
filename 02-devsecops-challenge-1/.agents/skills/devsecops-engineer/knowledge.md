# DevSecOps Engineer — Senior Knowledge Map

This is a routing and reasoning map, not a claim that every technology is deployed at Papaya. Discover the actual stack and consult current vendor/standards documentation before making product-specific decisions.

## 1. Cloud and infrastructure architecture
- AWS: account/OU boundaries, VPC/subnets/routes, security groups/NACLs, DNS, load balancing, compute, serverless, containers, storage, managed databases, queues/events, KMS, CloudTrail and service health.
- GCP: projects/folders, VPC, IAM, service accounts, Workload Identity Federation, Vertex AI, Cloud Logging/Audit Logs and resource-level authorization.
- Kubernetes/k0s: cluster/control-plane topology, node pools, namespaces, RBAC, service accounts, admission, Pod Security, NetworkPolicy, ingress, storage, upgrades and workload identity.
- Firebase: project separation, Hosting channels, backend coupling, rules, service accounts and preview-to-production isolation.
- Infrastructure as Code: Pulumi stacks/state/providers/secrets; Serverless Framework and CloudFormation ownership; drift, import, state locking, preview/plan, policy and safe destruction.
- Network/security architecture: ingress/egress, segmentation, private endpoints, TLS, DNS, secrets distribution and dependency trust.

## 2. CI/CD and software supply chain
- GitHub Actions event model, permissions, reusable workflows, runners, environments, concurrency, caches, artifacts, OIDC, branch protection, CODEOWNERS and required checks.
- Build reproducibility, dependency pinning, provenance/attestation, SBOM, signing, artifact immutability and promotion.
- SAST, SCA, license, secret, container/image, IaC, Kubernetes, API/DAST and policy-as-code controls.
- Monorepo impact analysis: path filters, dependency graph, shared libraries, generated clients, base images and always-on global security checks.
- Release strategies: rolling, blue/green, canary, feature flags, progressive delivery, rollback and roll-forward.

## 3. Security engineering
- Threat modeling (assets, actors, entry points, trust boundaries, abuse cases, attack paths, impact and controls).
- IAM/authorization: least privilege, role separation, workload identity, federation, session duration, permission boundaries, break-glass and access review.
- Secrets lifecycle: issuance, storage, access, rotation, revocation, leak detection and incident handling.
- Secure SDLC, change management, separation of duties, vulnerability remediation and security exception expiry.
- AI/agent security: indirect prompt injection, tool overreach, confused deputy, memory/context poisoning, data exfiltration, subagent trust and denial-of-wallet.

## 4. Performance and capacity engineering
- Workload characterization: request mix, arrival rate, concurrency, payload size, burstiness and service-time distribution.
- Golden signals: latency (especially p95/p99), traffic, errors and saturation; resource metrics, queue age/depth and dependency latency.
- Capacity models: CPU/memory/IO/network limits, connection pools, worker concurrency, autoscaling lag, quotas and headroom.
- Bottleneck analysis: profiling, traces, flame graphs, query plans, lock contention, N+1 calls, serialization, cold starts and noisy neighbors.
- Optimization: caching and invalidation, batching, async work, connection reuse, backpressure, load shedding and admission control.
- Cost/performance: cost per request/job/claim, model token/compute spend, storage/egress and idle capacity.
- Never optimize from averages alone or raise concurrency without checking downstream saturation and retry amplification.

## 5. Reliability, HA and DR
- SLI/SLO/error budgets, availability models, dependency budgets and graceful degradation.
- Failure domains: process, node, zone, region, account/project, network, identity provider, DNS, CI provider, model provider and data store.
- HA patterns: redundancy, health checks, load balancing, quorum, failover, replication, queue isolation and circuit breakers.
- DR: RTO/RPO, backup immutability, restore validation, cross-region/account strategy, failover/failback, dependency recovery and runbooks.
- Resilience testing: chaos/fault injection, game days, restore drills, failover tests and capacity under degraded mode.
- Recovery correctness includes data integrity, idempotency, replay safety and prevention of duplicate side effects.

## 6. Observability and operations
- Logs, metrics, traces, events, audit records and correlation IDs across source → CI → deployment → runtime.
- Alert quality: actionable thresholds, symptom-based paging, deduplication, routing, escalation and ownership.
- Incident command, severity, timeline, containment, forensics, customer impact, communication, postmortem and corrective actions.
- Operational readiness: service owner, SLO, dashboards, alerts, runbooks, backup/restore, rollback, access review and on-call.
- Change risk: deployment health, error-budget policy, maintenance windows and freeze/rollback criteria.

## 7. AI-assisted engineering
- Task decomposition, context selection, source tracing, retrieval freshness, model/tool selection and bounded delegation.
- Distinguish deterministic automation from model judgment; use schemas and policy checks for machine-executable outputs.
- Tool permission surfaces include local shell/filesystem/network and remote MCP/API tools; inspect both.
- Evaluate model-generated changes with the same tests and review as human changes, plus prompt-injection and tool-abuse scenarios.
- Preserve raw session evidence where required; do not confuse transcript, model trace, audit log and reproducible test output.

## 8. Frameworks and authoritative references
Use current primary sources and verify editions/versions:
- NIST SSDF SP 800-218: https://csrc.nist.gov/pubs/sp/800/218/final
- NIST AI RMF: https://www.nist.gov/itl/ai-risk-management-framework
- NIST GenAI Profile: https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence
- OWASP GenAI Security Project: https://genai.owasp.org/
- AWS security and Well-Architected guidance: https://docs.aws.amazon.com/
- GitHub Actions security: https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions
- Google Cloud IAM/WIF: https://cloud.google.com/iam/docs
- Kubernetes security: https://kubernetes.io/docs/concepts/security/

Standards, vendor recommendations, organizational controls and legal obligations are different authority classes. Framework names do not prove compliance.
