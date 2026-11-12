# QA Engineer — Papaya specialist knowledge

## Acceptance design
- Trace employer requirement → risk → control → enforcement point → positive/negative test → evidence → accountable owner.
- Define actor, identity, environment, preconditions, input, action, expected result, observable evidence and pass/fail criteria.
- Separate test design from execution; record exact source SHA, test version, environment and result.
- Use synthetic or sanitized data only. Never access real claims, medical, identity or banking data.

## Papaya-specific test families
- **Coding-agent runtime:** verify developer sessions cannot read production credentials, AWS SSO caches, SSH keys or unrelated host mounts; deny unauthorized filesystem/network/process access.
- **Prompt injection and tools:** malicious repository content/documents cannot grant authority; unapproved MCP/plugin/skill versions are rejected; tool arguments are schema-validated and authorized externally.
- **GitHub and CI:** untrusted PR jobs receive no production secrets or id-token; token permissions are minimal; action pins are immutable; workflow/IaC/IAM changes require independent review.
- **Production approval:** changed commit/artifact/plan/environment invalidates approval; the agent cannot self-approve or bypass protected environments.
- **Cloud identity:** AWS OIDC and GCP WIF trust rejects wrong repository/ref/workflow/environment and expired/unintended identity.
- **Production AI and tenancy:** cross-tenant retrieval/API/DB/object-store/queue/cache/vector access is denied; unsafe generated SQL/GraphQL/output is rejected.
- **Reliability and operations:** queue replay is idempotent; retries do not create duplicate side effects; kill switch stops workers/tools, revokes credentials, holds queued work and preserves audit evidence; rollback restores service safely.
- **Observability:** task/session/tool/PR/commit/run/approval/deployment/cloud-event correlation exists without indiscriminate sensitive-payload logging.

## Test taxonomy and limits
Positive tests prove allowed work; negative tests prove denied work; boundary tests verify limits and expiry; bypass tests attempt alternate paths; resilience tests cover interruption and recovery; regression tests preserve prior behavior. A proposed test case is not executed evidence. Static configuration checks do not prove runtime enforcement. Mocked identity/data tests do not prove production IAM or tenant isolation.

## References
- OWASP Top 10 for Agentic Applications: https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/
- OWASP GenAI Security Project: https://genai.owasp.org/
- NIST SSDF SP 800-218: https://csrc.nist.gov/pubs/sp/800/218/final
- NIST AI RMF: https://www.nist.gov/itl/ai-risk-management-framework
- GitHub Actions security hardening: https://docs.github.com/en/actions/security-for-github-actions/security-guides/security-hardening-for-github-actions

Verify the current taxonomy edition and test against the actual architecture. Framework labels are not test results.
