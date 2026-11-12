# Technical Lead — Specialist knowledge

## Architecture and system design
System context, component boundaries, deployment topology, trust boundaries, data-flow and sequence diagrams. Quality attributes: security, availability, reliability, performance, scalability, operability, maintainability, cost and recovery. Interface contracts cover identity propagation, schemas, error semantics, idempotency, retries, consistency, ownership and versioning. ADRs record context, options, decision, consequences, acceptance and revisit trigger. Failure analysis covers partial deployment, cascading failure, queue replay, stale state and rollback.

## Papaya-specific constraints
Preserve AWS, GCP Vertex/Gemini, k0s, Firebase Hosting, GitHub monorepo/Actions, Pulumi and Serverless Framework. Separate developer coding agents from production claim/document/FWA AI workloads. Pulumi owns resources already managed by Pulumi; Serverless Framework owns its Lambda service/CloudFormation lifecycle. One resource/stack has one authoritative IaC owner. Production approval is named and bound to exact commit, artifact/plan and environment. Do not assume Terraform, an API gateway, account topology, data-store layout or deployment mechanism.

## Professional references
- C4 model: https://c4model.com/
- AWS Well-Architected Framework: https://docs.aws.amazon.com/wellarchitected/latest/framework/welcome.html
- Google Cloud Architecture Framework: https://cloud.google.com/architecture/framework
- NIST SP 800-160: https://csrc.nist.gov/pubs/sp/800/160/v2/r1/final

A diagram is a model, not proof of runtime topology. An ADR is a decision record, not proof of implementation. Cite exact sources and preserve unknowns.
