# DevOps Engineer — Senior Platform Knowledge Map

## CI/CD and release engineering
GitHub Actions event triggers, workflow/job permissions, reusable workflows, runner isolation, concurrency, cache poisoning, artifacts, environments, approvals, OIDC, pinned actions, branch protection, CODEOWNERS and deployment provenance. Build reproducibility, SBOM, signing, attestation, immutable promotion, canary, blue/green, rolling and rollback.

## Cloud and IaC
AWS IAM, STS, OIDC trust, account boundaries, VPC, load balancing, Lambda, ECS/EC2, Aurora, S3, SNS/SQS, Step Functions, CloudWatch, CloudTrail and KMS. GCP IAM, service accounts, Workload Identity Federation, project boundaries, Vertex AI and Cloud Audit Logs. Pulumi stacks/state/providers/secrets/drift; Serverless Framework and CloudFormation ownership; k0s/Kubernetes service accounts, RBAC, admission, NetworkPolicy and upgrades; Firebase project/preview isolation.

## Performance and capacity
Workload shape, arrival rate, concurrency, service-time distributions, p50/p95/p99, throughput, saturation, queue depth/age, connection pools, CPU/memory/IO/network, autoscaling lag, quotas and headroom. Profiling, traces, flame graphs, query plans, lock contention, cold starts, cache hit/miss, batching, async processing, backpressure, admission control and load shedding. Cost per request/job and dependency egress.

## Reliability and resilience
SLI/SLO/error budgets, availability and dependency budgets, graceful degradation, bulkheads, circuit breakers, bounded retries, timeout budgets, idempotency, queue replay, rate limits and overload control. Failure domains include process/node/zone/region/account, network/DNS, identity provider, CI provider, model provider and data stores.

## HA and DR
Redundancy, health checks, replication, quorum, failover, backup immutability, restore validation, cross-account/region recovery, failback, data integrity, RTO/RPO, runbooks, game days and chaos/fault-injection testing. Distinguish high availability from disaster recovery and backup existence from successful restoration.

## Observability and operations
Logs/metrics/traces/events/audit, correlation IDs, golden signals, actionable alerts, escalation, on-call, incident command, containment, forensics, postmortems, service ownership and operational readiness.

## Security and governance interfaces
Least privilege, OIDC/WIF, secrets lifecycle, runner isolation, supply-chain controls, environment approvals, change freeze, separation of duties, IAM policy tests and evidence retention.

Use current vendor documentation and actual service topology before implementation. Unknown targets and unverified provider behavior must remain explicit.
