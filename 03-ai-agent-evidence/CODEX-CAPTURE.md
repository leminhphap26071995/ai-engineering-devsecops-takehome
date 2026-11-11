# Codex Local Conversation Capture — Windows

## Purpose and status

The owner reports that a ChatGPT Free account is now available for Codex. OpenAI's current Help Center says Codex is included on Free, with plan-dependent usage limits; Codex Cloud is not included on Free. Use a local Codex client (Codex CLI or the Codex desktop app) for this workflow, not a cloud task.

OpenAI's Codex source describes its recorder as persisting canonical session rollouts in JSONL so sessions can be replayed or inspected. The local file location and client behavior must still be verified on the owner's installed Windows version; do not assume a path or export contract without the probe.

References:
- OpenAI Help Center — Codex with ChatGPT plans: https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan
- Official Codex recorder source: https://github.com/openai/codex/blob/main/codex-rs/rollout/src/recorder.rs
- Codex CLI prompting guide / AGENTS.md behavior: https://developers.openai.com/cookbook/examples/gpt-5/codex_prompting_guide

## 0. Install the repository-pinned UPW plugin

From the root of this repository, add its repo-local marketplace:

~~~powershell
codex plugin marketplace add .
~~~

For Codex CLI, install the plugin from the configured repo marketplace:

~~~powershell
codex plugin add unified-project-workflow@papaya-codex-workflow
codex plugin list --json
~~~

For Codex in the ChatGPT desktop app, open the Plugins Directory, select **Papaya Codex Workflow**, and install **Unified Project Workflow**. Restart/open a new local Codex session in this repository.

The marketplace pins the plugin source to:
- Version: \`0.1.98\`
- Repository: \`leminhphap-improvement/ai-workflow-archtiecture\`
- Exact source commit: \`7b19d78bd3db8091d5ab5aa827031c60065e49bc\`
- Plugin path: \`plugin/overlay\`

Verify that the plugin appears as installed and that the relevant skills are available. A marketplace entry, manifest or installed status does not prove a skill was invoked. Record installation/version and actual skill invocation separately in the configuration/evidence manifest.

The plugin provides workflow instructions and reusable skills only. It does not bundle Notion/Jira/Confluence/GitHub credentials, MCP servers or provider access. Connect only the providers required by the project through the active host and verify identity, scopes, tools and a harmless read. Do not assume a Jira or Confluence integration is present.

### 0.1 Verify project config and specialist role setup

The repository includes a Codex-specific configuration package:

- `.codex/config.toml`: project defaults (`approval_policy = "on-request"`, `sandbox_mode = "workspace-write"`), multi-agent enabled with up to three concurrent supporting threads, and UPW plugin enabled for this project.
- `.codex/agents/security-reviewer.toml`, `devops-engineer.toml`, `qa-engineer.toml`, `ai-native-tooling-engineer.toml`: read-only custom-agent adapters; no model/provider is hardcoded.
- `.agents/skills/`: five project-local, complete four-artifact role bundles with source provenance in `.agents/skills/role-pack-provenance.json`.
- `.codex/README.md`: configuration and role routing summary.

Codex loads project `.codex/config.toml` only after the owner trusts the repository. CLI flags and managed requirements can affect effective settings. These files are project defaults, not proof of local activation or host enforcement.

Verify from the repository root in the local Codex client:

~~~powershell
codex plugin list --json
~~~

Then start a new session and inspect available skills/custom agents (for CLI, use `/skills` and `/agents`). The expected project skills are `software-architect`, `role-security-reviewer`, `role-devops-engineer`, `role-qa-engineer` and conditional `ai-native-tooling-engineer`. The expected supporting agents are `security_reviewer`, `devops_engineer`, `qa_engineer` and conditional `ai_native_tooling_engineer`.

Use the main Codex thread as the `software-architect` primary. Spawn only the relevant read-only supporting agent for the active phase. Do not spawn every role just to prove the configuration. Record actual skill invocations and every actual subagent session in the manifests.

The project config deliberately leaves model, reasoning effort, provider, global MCP servers and credentials to the local host. Record their actual values after session readback; never invent them from defaults.


## 1. Local client and configuration snapshot

1. Open Codex locally and sign in with the owner's Free account.
2. Record client type (desktop or CLI), exact version, OS, selected model, reasoning effort, approval policy, sandbox mode, and any enabled MCP servers/plugins/skills.
3. Record only non-secret settings in [AI-CONFIGURATION-MANIFEST.md](AI-CONFIGURATION-MANIFEST.md). Record actual effective values, not merely the checked-in project defaults.
4. Do not copy auth databases, tokens, API keys, environment secrets, cookies or the entire config directory into the repository.
5. Do not enable broad filesystem/network/terminal permissions just to make the capture easier. Use the narrowest available local sandbox/approval settings.
6. Open the existing submission repository as a local folder. Confirm the intended branch and clean/known working tree before allowing edits.

## 2. One harmless capture probe — required before substantive work

Start one local Codex conversation in the repository and send:

~~~text
This is a transcript-capture verification probe only.
Do not edit, create, delete, rename or stage any files.
Do not run terminal commands, tests or scripts.
Do not call MCP tools or access external services.
Read only the root README.md and AGENTS.md.
Reply with the repository title, the assessment's two workstreams, and one repository-safety rule.
~~~

Verify the answer is visible in the conversation. End the session normally and close the Codex client cleanly so local persistence is flushed. This is the only planned probe; do not create repeated probe sessions.

## 3. Locate the native local session record

Codex supports a configurable CODEX_HOME. In PowerShell, resolve it without assuming the default:

~~~powershell
$codexHome = if ($env:CODEX_HOME) { $env:CODEX_HOME } else { Join-Path $HOME '.codex' }
$sessions = Join-Path $codexHome 'sessions'
Get-ChildItem -LiteralPath $sessions -Filter 'rollout-*.jsonl' -File -Recurse |
  Sort-Object LastWriteTime -Descending |
  Select-Object -First 20 FullName, Length, LastWriteTime
~~~

Identify the exact file created by the harmless probe using its timestamp, session ID and repository working directory. Do not blindly select the newest file if other Codex sessions were active.

The common default layout reported by local Codex clients is under .codex/sessions/<year>/<month>/<day>/, but CODEX_HOME and client versions can change the location. The actual probe is the authority for this machine.

## 4. Check whether the raw record is shareable

Before copying anything into a public repository:
- Confirm the record belongs to the probe and includes the expected user request and assistant response.
- Determine whether it contains tool calls/results, environment paths, local file contents, credentials, personal data, or provider-internal base/system/developer instructions.
- Codex's recorder source includes session metadata such as base instructions and tool definitions in its session model. A native rollout is therefore not automatically safe to publish just because it is a conversation file.
- Never publish provider-internal system/developer instructions, credentials, tokens, cookies, private personal data or employer/customer data.
- Never silently edit, redact, truncate or reconstruct a transcript when the requirement is raw and unedited.
- If the native file contains non-shareable content, stop. Preserve it privately and ask HR whether a user-visible conversation export that excludes provider-internal instructions is acceptable. Do not claim the raw-transcript requirement is satisfied until an acceptable complete export format is confirmed.

## 5. Preserve an approved raw file unchanged

Only if the probe record is complete and safe to share, copy it byte-for-byte:

~~~powershell
$source = 'C:\exact\verified\path\to\rollout-session.jsonl'
$destination = '03-ai-agent-evidence\raw\codex\codex-probe-session.jsonl'
New-Item -ItemType Directory -Force -Path (Split-Path $destination) | Out-Null
Copy-Item -LiteralPath $source -Destination $destination
Get-FileHash -LiteralPath $source -Algorithm SHA256
Get-FileHash -LiteralPath $destination -Algorithm SHA256
~~~

The source and destination SHA-256 values must match. Record the session ID, local file path, capture timestamp, client/version, repository branch/commit and hash in session-manifest.md. Keep the original native file unchanged.

Do not commit the probe record if it contains any non-shareable content. In that case mark the capture gate BLOCKED and obtain an acceptable export path first.

## 6. Substantive assessment sessions

After the probe gate passes:
1. Start a fresh local Codex session for the actual Challenge 1 work.
2. Keep the session focused on the Papaya assessment and this repository only.
3. Ask Codex to inspect the current source/PR, challenge requirements, architecture and gaps before making changes.
4. Work in coherent batches; do not create micro-commits, irrelevant tests or duplicate files.
5. Capture every assessment-relevant Codex session, including separately invoked subagents/forks and every project-local language-bridge prepare/finalize helper session. The bridge creates separate codex exec sessions; its JSON event trace is not a native transcript.
6. If ChatGPT or another AI is used to materially produce assessment content, inventory that assessment-relevant conversation too and preserve an acceptable export/configuration record.
7. Record model, version, reasoning effort, effective approval/sandbox settings, tools/MCP/plugins/skills, actual custom-agent invocations and the applicable AGENTS.md/configuration hashes. Never include secrets.
8. Inspect generated work independently. Codex output is not self-validating.

### 6.1 Project-local language-bridge helper sessions

When scripts/language_bridge.py is used, each prepare and finalize operation starts a separate Codex exec session. These helper sessions are assessment-relevant AI conversations, even though they only normalize or translate content.

For each helper invocation:
- Record task ID, stage (prepare/finalize), timestamp, exact model, native session ID, event-trace path and the main session that invoked it.
- Locate the corresponding native rollout under the verified CODEX_HOME using its session ID/time and isolated working directory.
- Review the native rollout for completeness and shareability, calculate SHA-256 and add a separate row to the conversation manifest.
- Preserve the script's JSON event trace as diagnostic metadata only; it is not a replacement for the native rollout or a user-visible complete export.

If any helper session cannot be captured completely and safely, mark LANGUAGE_BRIDGE_USE=BLOCKED for the assessment. Do not run the bridge for assessment content; keep the main Codex conversation in the user's source language until HR-approved capture is available.

## 7. Final reconciliation

Before submission:
- Every AI conversation actually used for the assessment is listed in the manifest.
- Every required conversation has a complete, acceptable, unedited export and integrity hash.
- Every configuration record identifies the client, model/version, non-secret settings and enabled tools.
- Every subagent/fork session is accounted for.
- No transcript or configuration contains secrets, provider-internal instructions, private unrelated data or employer/customer data.
- The repository has one coherent history; no irrelevant test artifacts or unnecessary commits.
- Owner reviews the complete repository and explicitly authorizes the final link to HR.
