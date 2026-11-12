# Codex authoring configuration — candidate-side inventory

## Purpose and boundary

This file describes the **candidate's Codex authoring workspace only**. It does not configure Papaya's developer fleet, Claude Code Team Premium, production AI workloads, GitHub deployment policy or AWS/GCP identities.

The employer's Claude Code Team Premium reference remains a Papaya scenario fact. This repository revision contains the candidate-side Codex adapter at the repository root and does not include a `.claude/` project adapter. Claude-specific controls in the solution are target-state recommendations for Papaya, not candidate-side configuration. Open the repository root as the Codex workspace; do not start Codex from this assessment subfolder.

## Checked-in project defaults

| Path / key | Checked-in value | Meaning / limit |
|---|---|---|
| `.codex/config.toml` — `approval_policy` | `on-request` | Interactive approval behavior; not IAM or an independent security boundary |
| `.codex/config.toml` — `sandbox_mode` | `workspace-write` | Main-thread workspace write boundary, subject to host/user/managed policy |
| `[agents].enabled` | `true` | Enables Codex multi-agent tools |
| `max_concurrent_threads_per_session` | `2` | At most two spawned specialist threads concurrently, excluding the main thread |
| `.codex/agents/*.toml` | Five specialist definitions | Read-only reviewer defaults; actual invocation must be observed in Codex |
| `.agents/skills/papaya-takehome/SKILL.md` | Canonical task skill | Host-neutral assessment workflow, invoked from Codex |
| `02-devsecops-challenge-1/.agents/skills/<role>/` | Four-artifact role packs | Primary DevSecOps plus bounded supporting specialists |

Codex project settings are loaded only when the project is trusted. User, managed or system settings and live runtime overrides can affect effective permissions. Custom agents inherit the parent session's environment and permissions unless a supported per-agent setting overrides them; read-only configuration is not proof that MCP tools or every external capability are harmless.

## Runtime discovery and verification

Before using Codex for assessment work, confirm these details in the running client:
- client surface (CLI/desktop/IDE), version and model;
- workspace root, branch, exact HEAD and working-tree status;
- instruction files and task skill actually loaded;
- custom agents actually discovered and available;
- effective sandbox/approval settings and inherited tool/MCP capabilities;
- native session persistence/export path and completeness.

The repo cannot verify the candidate's local runtime. File presence is `SOURCE VERIFIED`; runtime discovery is `UNKNOWN` until observed in the real client.

## Role and write policy

- Main thread: Project Manager coordination + Technical Lead integration + DevSecOps Engineer primary; this is the only writer.
- Child agents: AI Agent Security, AI Native, DevOps, Security Assurance and QA; read-only, bounded assignments.
- Maximum two child threads concurrently; use staged waves to prevent conflicting work and excessive context.
- Each child receives requirement IDs, exact SHA, source paths, scope/non-scope, decision question and expected evidence.
- A role file is not an invocation. Same-session child review is not independent human QA.

## Native transcript evidence

The employer requires every coding-agent conversation used for this challenge. Complete the harmless capture probe first, then export every actual Codex main/child session as a complete, raw, unedited native file. Preserve the original byte-for-byte, calculate SHA-256 separately, and reconcile it in `evidence/SESSION-CAPTURE-RECORD.md`. Do not invent session IDs, model versions, paths, hashes or share URLs.

See [Codex execution plan](ai/CODEX-EXECUTION-PLAN.md), [capture procedure](evidence/CODING-AGENT-CAPTURE.md) and [session manifest](evidence/SESSION-CAPTURE-RECORD.md).
