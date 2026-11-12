# Residual risks and open decisions

## Residual risks

- Prompt injection may influence low-risk behavior; isolation and least privilege reduce impact but do not remove the threat.
- Model/provider retention, routing and data residency may vary by contract/configuration.
- Tool registries can be compromised through maintainers, dependencies or signing processes.
- CI policy can be weakened by trusted administrators or compromised runners.
- Human reviewers may approve incorrect changes or become overloaded.
- Audit pipelines may lose events or expose sensitive metadata.
- Tenant isolation defects may exist below the agent layer.
- Emergency access can bypass normal paths unless separately governed.

## Decisions requiring organization-specific validation

- Which agent runtimes and model providers are approved for each data classification?
- Which tasks may use real claims data, if any, and under what legal basis/contract?
- Which jurisdictions and insurer agreements govern each processing path?
- What retention/deletion periods apply to prompts, tool traces and raw sessions?
- Which actions are high-risk and who may approve them?
- What network isolation is feasible for each agent runtime?
- Which immutable logging and artifact-attestation services exist?
- What recovery objectives and rollback constraints apply to each workload?

## Limitations

This is a reference design based on the employer's written scenario. It is not a security assessment, legal opinion, implementation plan approved by Papaya, audit report or certification.
