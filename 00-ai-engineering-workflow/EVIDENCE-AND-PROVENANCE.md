# Evidence and Provenance

## Evidence states

| State | Meaning | Example |
|---|---|---|
| DESIGNED | Method/architecture documented | This architecture snapshot |
| IMPLEMENTED | Code/config exists in source | Committed workflow file |
| INSTALLED | Tool installed in a host | Verified local installation |
| CONNECTED | Integration handshake/auth succeeded | MCP initialize + tools/list |
| INVOKED | Tool/agent actually executed | Recorded session or tool result |
| VERIFIED | Defined oracle passed with retained evidence | Exact-SHA CI and inspected logs |
| ACCEPTED | Authorized reviewer accepted outcome | Human approval record |

These states are not interchangeable. A test plan is not an executed test.

## Provenance record

Record goal/ticket and requirement version; source repository/branch/SHA; input sources and revisions; agent/session ID and native raw transcript; tools invoked and result IDs; files changed; test commands and output; hosted CI run/attempt/job; reviewer decision; limitations and next action.

## Transcript integrity

- Preserve the native raw session file unchanged.
- Do not redact or edit the committed original; inspect for secrets first.
- If secrets are present, do not publish the raw file. Stop, assess exposure and rotate/revoke as appropriate.
- A human-readable summary may accompany a transcript but never replaces it.
- Record subagent sessions separately when they were actually invoked.
