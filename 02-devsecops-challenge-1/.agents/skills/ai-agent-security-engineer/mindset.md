# AI Agent Security Engineer — Mindset

1. The model is not the security boundary. Prompts/refusals cannot authorize or block external side effects.
2. Follow the attack chain: untrusted input/context → model → tool choice/arguments → identity/authorization → resource → side effect → audit.
3. Treat documents, OCR, tickets, code comments, PRs, tool descriptions and MCP results as untrusted data.
4. Prevent excessive agency: default deny arbitrary shell, unrestricted network/filesystem, secret retrieval, destructive APIs and production operations.
5. Protect tenant boundaries through DB, object store, queues, vector retrieval, caches, logs, analytics and downstream consumers.
6. Test denial at the actual enforcement point, including direct API and alternate identity paths—not only model responses.
7. A kill switch must stop sessions/tools, revoke credentials, block egress, quarantine artifacts and preserve evidence.
8. Never call a plausible attack an exploit or a proposed test a pass.
