# AI Configuration Manifest

This manifest records the non-secret configuration used for assessment-relevant AI conversations. Do not paste complete config files, credentials, API keys, cookies, auth databases or secret environment values here.

## Configuration record template

| Field | Value |
|---|---|
| Conversation / session ID | PENDING |
| AI product / client | PENDING |
| Client version | PENDING |
| Account plan / access mode | OWNER-REPORTED: ChatGPT Free; local Codex selected as intended candidate; actual local client/access not yet verified |
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
| Version | 0.1.98 |
| Marketplace | Repo-local \`.agents/plugins/marketplace.json\` |
| Canonical source repository | leminhphap-improvement/ai-workflow-archtiecture |
| Pinned source commit | 7b19d78bd3db8091d5ab5aa827031c60065e49bc |
| Plugin directory | plugin/overlay |
| Installed in actual Codex client | PENDING local verification |
| Relevant skill invoked in assessment session | PENDING local verification |
| Provider adapters connected | Record only the adapters actually connected and tested; none are implied by this plugin package |


## Planned role routing — not yet active in a Codex session

The owner-selected plan for Challenge 1 is to load only these pinned UPW role bundles, phase by phase:
- `software-architect` — accountable architecture owner.
- `security-reviewer` — threat model and agent/tool security.
- `devops-engineer` — CI/CD, deployment and operational controls.
- `qa-engineer` — adversarial acceptance and evidence.

This is a planned routing decision, not proof that these skills are installed, enabled or invoked. Record actual session-enabled roles/skills only after local Codex verification.


## Project-local language bridge — planned, not active

| Setting | Intended value | Evidence state |
|---|---|---|
| Agent language | auto; source language unless exact-model profile is VERIFIED | PENDING local model/profile verification |
| User response language | Detected source language unless explicitly configured | PLANNED |
| Translator model | Codex configured model; optional UPW_TRANSLATOR_MODEL override | PENDING |
| Language profile | config/language-profiles.example.json; no measured profiles yet | PLANNED |
| Private state | ~/.upw/language-bridge | PLANNED |
| Helper execution | Separate codex exec calls, read-only sandbox, isolated work directory | Source-verified CLI flags; live invocation PENDING |
| Helper transcript capture | Native rollout per prepare/finalize session; event JSONL is not a substitute | BLOCKING / PENDING |
| Unit tests | 7 tests pass with mocked Codex subprocess | TOOL-OBSERVED in isolated development runner |
| Live Codex execution | Not run on owner's machine | NOT_VERIFIED |

Do not claim the bridge is active or use it for assessment content until the harmless capture probe and helper-session shareability checks pass.
