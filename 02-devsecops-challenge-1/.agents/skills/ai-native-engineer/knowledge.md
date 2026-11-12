# AI Native Engineer — Knowledge Base

## Workload architecture
Identify entry point/task trigger, runtime/workspace, instruction/context assembly, model/provider, tool registry/permission boundary, memory/state/retrieval, output validation/human review, downstream consumer, telemetry/evaluation and lifecycle owner.

## Papaya-specific separation
- **Developer coding agents:** Claude Code Team Premium, local developer workstations with AWS SSO, internal plugin marketplace, GitHub monorepo and GitHub Actions. Review managed settings, prompt/permission bypass, inherited profiles, MCP/plugin supply chain and source-control/CI scope.
- **Production AI agents:** claim assessment, document extraction/classification and FWA workloads in the employer's AWS/GCP/k0s environment. Exact agent topology, model routing, data stores, tenancy enforcement and deployment paths are unknown.

## Patterns and risks
- Use deterministic workflows for fixed state transitions, approvals, retries and irreversible actions.
- Separate model inference from data retrieval, tool execution and infrastructure administration.
- Use typed tools, strict schemas and authorization bound to task, identity, resource, action and expiry.
- Carry tenant identity through APIs, DB/RLS, object storage, queues, caches, vector retrieval, analytics and model context.
- Keep human approval outside the model; bind it to immutable change/artifact identity.
- Make retries idempotent; protect against duplicate queue events and replay.
- Evaluate prompt injection, unsafe output, tool misuse, retrieval isolation, model drift, resource exhaustion and denial-of-wallet.
- Treat prompts, tool arguments, outputs and traces as sensitive.

## References
- NIST AI RMF: https://www.nist.gov/itl/ai-risk-management-framework
- NIST GenAI Profile: https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence
- OWASP GenAI Security Project: https://genai.owasp.org/
- MCP specification: https://modelcontextprotocol.io/specification/
- AWS agentic AI security: https://docs.aws.amazon.com/prescriptive-guidance/latest/agentic-ai-security/
- Google Cloud GenAI security: https://cloud.google.com/docs/security/genai-security-bps
