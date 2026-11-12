# Native coding-agent conversation capture

## Mandatory gate
The employer requires a complete, raw, unedited conversation for every coding-agent session used. A missing coding-agent conversation is an automatic-fail condition. Use the native capture/export mechanism of the actual host and client selected for the work. Do not assume different clients (CLI, IDE extension, desktop or web) export the same content.

## Open the correct workspace
Open the repository root in the selected coding-agent client, trust it where applicable, and verify that it discovers the root instructions, task skill, host adapter and specialist definitions supported by that client. See [AI workspace setup](../ai/README.md) and [AI configuration](../AI-CONFIGURATION.md).

## Harmless capture probe — required before substantive coding-agent work
Use a new session in the selected native client. Send only this probe:

```text
This is a transcript-capture verification probe only.
Do not edit, create, delete or rename files.
Do not run terminal commands.
Do not call MCP tools or access external services.
Read only the repository-root README.md and report its title plus one repository safety rule.
```

Confirm the response appears in the client. End the session and use that client's documented or observable native export mechanism.

## Verify completeness and shareability
- Identify the exact probe session by its content and workspace, not just by newest timestamp.
- Confirm the export contains the complete user/assistant conversation and all relevant tool calls/results required by the employer.
- Inspect for provider-internal instructions, credentials, unrelated personal data or sensitive content.
- If incomplete or unsafe to share, stop and obtain an acceptable export approach. Do not edit/redact the original to force acceptance.

## Preserve each real session
Once complete and safe to share:
1. Copy the original export unchanged into `02-devsecops-challenge-1/evidence/raw-sessions/`.
2. Compute SHA-256 separately and record file size, native session ID, product/client/version, model, non-secret effective configuration and capture time in `SESSION-CAPTURE-RECORD.md`.
3. Verify the copied hash matches the source.
4. Capture every genuinely spawned child/fork separately.
5. Inventory every assessment-related AI conversation actually used, including supporting conversations if the employer requires them.

Put reviewer-accessible share URLs only in `AI-CONVERSATION-LINKS.md`. A role definition, skill invocation, same-thread perspective or JSON event summary is not a native conversation export. Never fabricate placeholders or reconstructed transcripts.
