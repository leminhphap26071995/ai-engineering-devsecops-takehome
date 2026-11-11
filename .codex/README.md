# Codex Project Runtime

This repository carries a Codex-specific adapter for the reusable Unified Project Workflow (UPW). It is a project configuration package, not proof that a local Codex host has installed or activated it.

## Configuration layers

- `config.toml`: project-scoped defaults, loaded only after the owner trusts this repository.
- `agents/*.toml`: narrow, read-only specialist subagents. They inherit the parent session's model/provider and do not configure credentials or MCP servers.
- `../.agents/plugins/marketplace.json`: pinned UPW plugin distribution source.
- `../.agents/skills/`: project-discoverable copies of five complete UPW role bundles. The provenance file records the exact canonical source commit and source Git blob IDs.

## Effective project defaults

| Setting | Repository value | Boundary |
|---|---|---|
| Approval | `on-request` | User-level/managed policy may constrain behavior |
| Parent sandbox | `workspace-write` | No broad host or production access is granted |
| Multi-agent | enabled | Codex must support custom agents in the installed client |
| Concurrent supporting threads | 3 | One primary plus up to three supporting threads |
| UPW plugin | enabled for this project | Must still be installed from the pinned marketplace |
| Model/provider | not pinned | Record actual session values |
| MCP servers | none declared | Do not assume external connections |

## Role model

The main session owns the `software-architect` primary role. Use these project-local skills explicitly:

- `$software-architect`
- `$role-security-reviewer`
- `$role-devops-engineer`
- `$role-qa-engineer`
- `$ai-native-tooling-engineer` (conditional for tooling setup only)

The Codex custom-agent adapters are:

| Custom agent | Skill bundle | Use |
|---|---|---|
| `security_reviewer` | `role-security-reviewer` | Threat model and security review |
| `devops_engineer` | `role-devops-engineer` | Delivery and operations review |
| `qa_engineer` | `role-qa-engineer` | Acceptance and adversarial test design |
| `ai_native_tooling_engineer` | `ai-native-tooling-engineer` | Conditional Codex/plugin setup review |

Each role skill instructs Codex to read all four artifacts in its directory. The software architect remains the accountable primary; same-session specialist perspectives are not independent human QA. Any actually spawned subagent is a distinct AI conversation for transcript inventory/capture.

## Installation and activation

Follow [Codex capture and setup](../03-ai-agent-evidence/CODEX-CAPTURE.md). In brief:

1. Trust the repository in the local Codex client.
2. Add the repository marketplace and install `unified-project-workflow@papaya-codex-workflow`.
3. Start a new local session and verify the plugin is installed and skills are discoverable.
4. Verify `/agents` or the custom-agent picker exposes the four configured custom agents.
5. Run the harmless transcript-capture probe before any substantive assessment session.

Do not copy user-level `~/.codex/config.toml`, auth data, credentials, cookies or MCP secrets into this repository. The repository configuration records intended project defaults; actual model, client version, reasoning effort, account and effective settings belong in the non-secret AI configuration manifest after local readback.
