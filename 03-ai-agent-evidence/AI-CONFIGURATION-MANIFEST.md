# AI Configuration Manifest

This file records non-secret configuration for every assessment-relevant AI conversation. It separates repository-defined Codex configuration from settings actually observed in the local Codex host. Never copy auth databases, credentials, tokens, cookies, secret environment values or provider-internal instructions here.

## 1. Repository-defined Codex configuration — SOURCE VERIFIED

These are version-controlled project files. Their presence does not prove the local Codex host loaded or activated them.

| Concern | Repository definition | Evidence state |
|---|---|---|
| Project config | `.codex/config.toml` | SOURCE_VERIFIED |
| Approval policy | `on-request` | SOURCE_VERIFIED — project default |
| Parent sandbox | `workspace-write` | SOURCE_VERIFIED — project default |
| Multi-agent | enabled | SOURCE_VERIFIED |
| Concurrent supporting threads | 3 | SOURCE_VERIFIED |
| UPW plugin | `unified-project-workflow` enabled for `papaya-codex-workflow` | SOURCE_VERIFIED — installation still pending local verification |
| UPW marketplace | `.agents/plugins/marketplace.json` | SOURCE_VERIFIED |
| UPW version/source | v0.1.98, `leminhphap-improvement/ai-workflow-archtiecture@7b19d78bd3db8091d5ab5aa827031c60065e49bc`, path `plugin/overlay` | SOURCE_VERIFIED |
| Custom agents | `security_reviewer`, `devops_engineer`, `qa_engineer`, `ai_native_tooling_engineer` under `.codex/agents/` | SOURCE_VERIFIED — read-only adapters |
| Project-local role skills | Five complete four-artifact bundles under `.agents/skills/` | SOURCE_VERIFIED |
| Role provenance | `.agents/skills/role-pack-provenance.json` | SOURCE_VERIFIED |
| Model/provider | Not pinned | Intentional; record actual local selection |
| MCP servers | None declared in project config | Does not establish whether user-level/global MCP servers exist |

### Role assignment

- Challenge 1 primary: `software-architect` in the main Codex thread.
- Challenge 1 supporting roles, invoked by phase: `role-security-reviewer`, `role-devops-engineer`, `role-qa-engineer`.
- Conditional setup role: `ai-native-tooling-engineer`.
- Logical Questions: no engineering role; Q1/Q5 require owner-supplied facts.
- Each actual spawned subagent is a separate assessment-relevant session and must be inventoried/captured.

Canonical role source and source artifact Git blob IDs are recorded in `.agents/skills/role-pack-provenance.json`. The local role skills instruct Codex to load all four artifacts in their own directory.

## 2. Local Codex host configuration — PENDING OWNER WORKSTATION READBACK

| Field | Actual value |
|---|---|
| Client type (CLI / Desktop) | PENDING |
| Exact client version | PENDING |
| OS / runtime | OWNER DEVICE: Windows (reported in capture guide); exact version PENDING |
| Account plan / access | OWNER-REPORTED: ChatGPT Free with Codex access; local authentication PENDING |
| Model identifier | PENDING |
| Reasoning effort / mode | PENDING |
| Effective approval policy | PENDING host readback |
| Effective sandbox / network policy | PENDING host readback |
| Project trust status | PENDING |
| UPW plugin installed/version | PENDING |
| UPW skills discovered and invoked | PENDING |
| Custom agents discovered | PENDING |
| User/global MCP servers enabled | PENDING; do not assume none |
| Capture location / CODEX_HOME | PENDING harmless probe |
| Capture timestamp (ICT) | PENDING |

Do not replace PENDING values with the repository defaults. CLI flags, project trust, user configuration and managed requirements can affect the effective session settings.

## 3. Per-conversation configuration record

Create one record for each materially different configuration used by an assessment-relevant conversation.

| Field | Value |
|---|---|
| Conversation / native session ID | PENDING |
| AI product / client and exact version | PENDING |
| Account plan / access mode | OWNER-REPORTED: ChatGPT Free; local Codex must be verified |
| Model identifier | PENDING |
| Reasoning effort / mode | PENDING |
| Effective approval policy | PENDING |
| Effective sandbox / network policy | PENDING |
| Workspace / repository | leminhphap26071995/ai-engineering-devsecops-takehome |
| Branch and starting commit SHA | PENDING per session |
| Enabled plugins | Record actual installed/enabled plugins |
| Invoked skills / roles | Record actual invocation, not merely available files |
| Spawned custom agents | Record only agents actually spawned and their native session IDs |
| Enabled MCP servers | Record actual host connections and scopes; never include credentials |
| Project instruction/config files | Record exact paths and SHA-256 |
| Capture timestamp (ICT) | PENDING |
| Transcript manifest row | PENDING |
| Secret/shareability review | PENDING |

## 4. Configuration capture rules

- Record the exact model and client version shown by the local Codex client.
- Record effective reasoning, approval, sandbox and network settings as observed.
- List only plugins, skills, custom agents and MCP servers actually enabled/invoked for that session.
- Include root `AGENTS.md`, `.codex/config.toml`, the relevant custom-agent TOML files, `.agents/plugins/marketplace.json`, and any other project instructions/configuration by path and SHA-256.
- Do not copy the user's global `~/.codex/config.toml` wholesale. Record only non-secret effective settings needed to explain the session.
- Do not publish auth databases, provider-internal base/system/developer instructions, secrets, unrelated personal data or private employer/customer data.
- A repository file is not proof it was loaded. A plugin marketplace entry is not proof it was installed. A skill file is not proof it was invoked. A custom-agent TOML is not proof an agent was spawned.
- Keep one record per materially different configuration; do not duplicate unchanged records.

## 5. Transcript and language-bridge boundaries

Every assessment-relevant conversation actually used must be listed in `session-manifest.md`, including the main Codex session, every actually spawned subagent/fork, any helper session, and material ChatGPT conversations.

The project-local language bridge is not enabled for assessment content. It creates separate Codex helper sessions for prepare/finalize; its JSON event trace is not a native transcript. Do not use it until every helper session can be captured completely and safely.
