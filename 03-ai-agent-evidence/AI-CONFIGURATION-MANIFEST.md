# AI Configuration Manifest

This manifest records the non-secret configuration used for assessment-relevant AI conversations. Do not paste complete config files, credentials, API keys, cookies, auth databases or secret environment values here.

## Configuration record template

| Field | Value |
|---|---|
| Conversation / session ID | PENDING |
| AI product / client | PENDING |
| Client version | PENDING |
| Account plan / access mode | OWNER-REPORTED: ChatGPT Free; local Codex availability not yet verified |
| Model identifier | PENDING |
| Reasoning effort / mode | PENDING |
| Approval policy | PENDING |
| Sandbox / execution policy | PENDING |
| Workspace / repository | leminhphap26071995/ai-engineering-devsecops-takehome |
| Branch and starting commit | PENDING |
| Enabled MCP servers / plugins | PENDING |
| Enabled skills / project instructions | Root AGENTS.md; exact hash pending after local readback |
| Relevant non-secret config file(s) | PENDING |
| Configuration capture timestamp (ICT) | PENDING |
| Transcript manifest row | PENDING |
| Secret review | PENDING |

## Configuration capture rules

- Record the exact model and client version shown by the local Codex client.
- Record reasoning, approval and sandbox settings as actually observed, not intended defaults.
- List only MCP servers, plugins and skills actually enabled for the captured session.
- Include the project AGENTS.md and any relevant repository-level Codex config by path and SHA-256.
- If a global config file contains credentials or unrelated settings, do not copy it. Record only the non-secret settings needed to reproduce the session.
- Do not claim a configuration was active merely because a file exists; confirm the session's observed settings.
- Keep one record per materially different configuration. Do not create duplicate records for unchanged settings.


## UPW plugin provenance

| Field | Value |
|---|---|
| Plugin | Unified Project Workflow |
| Version | 0.1.97 |
| Marketplace | Repo-local \`.agents/plugins/marketplace.json\` |
| Canonical source repository | leminhphap-improvement/ai-workflow-archtiecture |
| Pinned source commit | fd981a03839566875146e9c853b52861db63396d |
| Plugin directory | plugin/overlay |
| Installed in actual Codex client | PENDING local verification |
| Relevant skill invoked in assessment session | PENDING local verification |
| Provider adapters connected | Record only the adapters actually connected and tested; none are implied by this plugin package |
