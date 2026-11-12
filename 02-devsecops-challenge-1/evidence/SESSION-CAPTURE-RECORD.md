# Coding-agent session capture record

This inventory covers actual coding-agent sessions used for the assessment. ChatGPT planning/review is not a substitute for a coding-agent transcript and is not listed as a coding-agent session.

| Session / purpose | Product / client | Assessment use | Native export | Integrity / shareability | Status |
|---|---|---|---|---|---|
| Harmless capture probe | Codex in VS Code; exact client/version/model/session details pending owner readback | Verify native session persistence and export | Owner to provide native export or reviewer-shareable link | No placeholder or reconstructed export created | PENDING OWNER EVIDENCE |
| Main assessment session | Codex in VS Code; exact client/version/model/session details pending owner readback | Primary authoring for the assessment | Owner-provided reviewer-shareable link recorded; native export not provided | Owner confirmed the link is accessible; no placeholder or reconstructed export created | LINK CONFIRMED / METADATA PENDING |
| `01a1cf66-cc9b-73c2-b2dd-fa205226f94f` | Codex specialist subagent — AI Agent Security | Bounded read-only D-01..D-05 review | Owner to provide native export or reviewer-shareable link if required | Returned review; no file fabricated | USED / EXPORT PENDING |
| `01a1cf66-cd44-7572-aa2c-cb1226c220f4` | Codex specialist subagent — AI Native | Bounded read-only D-09..D-10 review | Owner to provide native export or reviewer-shareable link if required | Returned review; no file fabricated | USED / EXPORT PENDING |

## Capture requirements
- Record actual product/client type and version, model and non-secret effective settings from the real session.
- Include prompts, responses, relevant tool calls/results and every actual child/fork.
- Preserve native exports byte-for-byte; calculate SHA-256 separately.
- Inspect completeness and reviewer shareability before submission.
- Exclude credentials, cookies, tokens, private keys, provider-internal instructions, unrelated private data and customer/claim/medical/identity/banking data.
- Never silently redact or reconstruct a raw export. If unsafe or not shareable, stop and obtain an acceptable method.
- PENDING is not evidence that a session occurred or an export exists.

## Current capture status

The owner provided and confirmed access to a reviewer-shareable link for the main assessment session through the Codex interface in VS Code. Native raw files and exact session metadata remain pending; none has been created, reconstructed or silently redacted. E-01/E-05 remain pending because the probe and specialist-session evidence is not yet fully reconciled.

Raw originals belong under `evidence/raw-sessions/` only after verification. Hashes, session IDs and non-secret metadata belong here.
