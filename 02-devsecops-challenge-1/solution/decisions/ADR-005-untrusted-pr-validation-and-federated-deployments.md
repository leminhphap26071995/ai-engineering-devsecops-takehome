# ADR-005: Separate untrusted PR validation from federated deployment

- Status: Proposed
- Decision owner: CI/CD platform owner + Cloud IAM owner
- Date: 2026-11-12

## Context
The scenario reports long-lived GitHub and AWS credentials in repository secrets. Pull requests may contain agent-generated or attacker-controlled workflow/source changes.

## Decision
PR validation uses minimal GITHUB_TOKEN permissions and no production secrets or cloud id-token permission. Third-party Actions are pinned to immutable commit SHAs and reviewed. Deployment is a separate protected workflow/job with environment approval and short-lived federation: AWS OIDC and GCP Workload Identity Federation, each constrained to expected repository, ref, workflow and environment claims. Build once, attest provenance and promote the same immutable artifact.

## Consequences and verification
Workflow design and trust policies become explicit. Fork/untrusted PRs retain useful validation without privileged access. Verify fork/untrusted PRs cannot access secrets or request cloud tokens; unapproved refs/workflows cannot assume deploy roles; artifact digest and provenance are checked before deployment.

## Alternatives rejected
Long-lived cloud keys, id-token permission on every job and broad wildcard OIDC trust.
