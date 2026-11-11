# Coding-Agent and AI Conversation Evidence

Papaya's challenge brief requires a genuine coding-agent session and complete, raw, unedited conversation records for every coding-agent session used. The owner also reports a direct HR clarification on 2026-11-11 requiring assessment-related AI conversations and the AI configurations being used. HR confirmed the existing repository name is acceptable if all requirements are met.

## Target design versus candidate tool

- The **Papaya target-state design** remains Claude Code-aware because Appendix A names Claude Code as the organization's primary coding agent.
- The **candidate's intended assessment tool** is local Codex, selected by the owner. The local client/version, plugin installation/invocation and capture are not yet verified.
- Codex Free supports local Codex use subject to usage limits. Codex Cloud is not included with Free; use a local Codex CLI or desktop client for the planned capture.
- Cursor's Windows capture guide remains an optional fallback. It is not evidence that Cursor is currently selected or used.

## Evidence rules

- Inventory every assessment-relevant AI conversation actually used to produce the submission, including coding-agent and material ChatGPT/other AI conversations. Do not include unrelated personal conversations.
- Preserve each required conversation in a complete, acceptable, unedited native or user-visible export. Do not substitute summaries.
- Record non-secret AI configuration in [AI configuration manifest](AI-CONFIGURATION-MANIFEST.md).
- For local Codex, follow [Codex capture guide](CODEX-CAPTURE.md). Codex's native rollout recorder uses JSONL, but its shareability must be inspected before publishing; it may contain provider-internal instructions or sensitive tool output.
- For Cursor on Windows, see [Windows capture guide](WINDOWS-CAPTURE.md) and the PowerShell helpers under windows/.
- Record every real subagent/fork session separately if one is actually invoked.
- Preserve raw records byte-for-byte. Store hashes and explanatory metadata separately.
- If a raw record contains secrets, personal data, customer/employer data or provider-internal instructions, do not publish or silently redact it. Stop and obtain an acceptable export format.

**Current state:** Papaya target runtime = Claude Code (source-derived). Candidate runtime = local Codex (owner-selected; host setup and use not yet verified). Raw-session shareability and configuration capture remain blocking.


## UPW Codex plugin and provider portability

This repository references the canonical UPW plugin package rather than copying a second private workflow implementation into the submission:
- Codex plugin version: \`0.1.97\`
- Pinned canonical source commit: \`fd981a03839566875146e9c853b52861db63396d\`
- Repo-local marketplace: \`.agents/plugins/marketplace.json\`
- Core contract: [Provider-Adapter Architecture](https://github.com/leminhphap-improvement/ai-workflow-archtiecture/blob/fd981a03839566875146e9c853b52861db63396d/docs/PROVIDER-ADAPTER-ARCHITECTURE.md)

The workflow core is vendor-neutral. Work management and knowledge base are independent from source control and CI/CD. Notion + GitHub is one possible combination; Jira + Confluence with GitHub/GitLab/other source control is another. This repository's current source-control host is GitHub, but its contents and assessment evidence must not require access to the owner's private Notion workspace.

The package does not include provider MCP servers or credentials. Jira/Confluence adapters are future options, not implemented or verified in this submission. Provider connection and skill activation must be verified in the actual Codex host.
