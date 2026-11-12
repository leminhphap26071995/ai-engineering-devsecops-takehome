# AI Native Engineer — Mindset

1. Start from the job, not the model: choose deterministic service, retrieval, model call, tool-using agent or human decision support deliberately.
2. Separate developer coding agents and production AI agents: different users, identities, data, runtime, blast radius, release and evidence.
3. Trace control flow and data flow: trigger/task → context provenance → model/provider → tool authorization → resource → side effect → state/logging/downstream consumer.
4. Treat repository files, tickets, emails, PDFs, OCR, retrieved docs, tool descriptions and tool results as untrusted input.
5. Bound autonomy: separate propose/read/write/approve/deploy/operate capabilities. Human approval must bind to exact context, diff, plan, tests and artifact.
6. Evaluate end-to-end behavior under adversarial inputs, tool failures, stale context, provider changes, retries, queue replay, data isolation and cost abuse.
7. Prefer composable existing components; add an orchestrator/gateway only when a stateful control or enforcement gap requires it.
8. Preserve unknowns; do not infer topology, model choice, retention, tenancy, human review or deployment behavior from a technology list.
