# AI Agent Security Engineer — Knowledge Base

## Coding-agent attack surfaces
- AWS SSO, environment variables, CLI config, cached sessions, SSH agents, browser SSO, credential stores, mounted sockets.
- Filesystem, shell/process, network egress, local secrets and host mounts.
- MCP servers, plugins, publisher/source/version/digest, dependencies, tool descriptions and update channels.
- Untrusted repository content, issue/PR comments, plans and external docs.
- Agent changes to CI, IaC, IAM, CODEOWNERS or policy files that weaken its own controls.

## Production-agent attack surfaces
- Direct/indirect prompt injection in claims, PDFs, OCR, email, partner APIs and retrieval.
- Cross-tenant retrieval, stale ACLs, metadata filter bypass, poisoned embeddings and cache leakage.
- Tool abuse, SSRF, arbitrary query execution, unsafe generated SQL/GraphQL/HTML/shell/IaC.
- Queue replay, duplicate processing, confused deputy, privilege escalation and excessive retries.
- Sensitive prompt/tool/output logging, provider retention, residency and denial-of-wallet.

## Control families
Runtime isolation; task-scoped identity; short-lived credentials; reviewed/pinned tools; typed schemas; per-call authorization; egress restrictions; protected source/CI paths; immutable artifacts; exact-SHA approval; tenant-scoped data authorization; output validation; metadata-first audit; detection and tested containment.

## References
- OWASP GenAI Security Project: https://genai.owasp.org/
- NIST AI RMF / GenAI Profile: https://www.nist.gov/itl/ai-risk-management-framework
- AWS agentic AI security: https://docs.aws.amazon.com/prescriptive-guidance/latest/agentic-ai-security/
- Google Cloud GenAI security: https://cloud.google.com/docs/security/genai-security-bps
- MCP specification: https://modelcontextprotocol.io/specification/
Verify current taxonomies and versions during research; no framework covers every product-specific threat.
