# Agent discovery and context troubleshooting

Start with a simple check that distinguishes the likely causes. Do not dump the whole repository or restart the workflow without a reason.

| Symptom | Check / recovery |
|---|---|
| Codex instructions missing | Confirm the opened folder is the repository root; trust the workspace; start a new Codex session; ask it to identify loaded instruction sources. Root `AGENTS.md` is the entrypoint. |
| `$papaya-takehome` missing | Confirm `.agents/skills/papaya-takehome/SKILL.md` exists at repo root; restart Codex to refresh skill discovery; invoke the exact skill name. |
| Custom agent missing | Confirm root `.codex/agents/*.toml` files each define `name`, `description`, `developer_instructions`; inspect TOML syntax and actual Codex agent selector/runtime. |
| Project config not active | Confirm project trust and root `.codex/config.toml`; inspect user/managed/CLI overrides and effective permissions. Project config is a default, not a security boundary. |
| Agent reads wrong files | Verify current working directory and the task skill's exact paths; do not rely on paths relative to the old `02-devsecops-challenge-1/` working root. |
| Context lost or compacted | Read this summary, verify the live HEAD, recover the original requirement and first unmet gate, then load only the relevant role and source. Do not reconstruct facts from chat summaries. |
| Subagent output vague | Reassign with requirement IDs, exact SHA, scope/non-scope, 1–3 source paths, one decision question, output contract and falsifiable acceptance. |
| Token/context use too high | Do not preload all role packs or solution files. Main agent owns goal/decisions; primary role gets four files; supporting role gets four files only on invocation; delegate noisy search/log analysis and request distilled findings. |
| Same failure repeats | Record one hypothesis, evidence, expected signal, falsifier and discriminating test. After two uninformative attempts, change evidence route and mark unresolved cause UNKNOWN. |

## Codex permission and evidence boundaries

- Codex subagents inherit the parent's live permission mode; a custom agent's `read-only` setting is a default and may be superseded.
- Remote MCP/connector permissions are separate from the local sandbox. A read-only local sandbox does not prove remote tools are read-only.
- A committed config or role file proves only source presence—not runtime discovery, actual invocation or enforcement.
