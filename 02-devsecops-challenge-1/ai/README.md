# AI workspace — Codex authoring workflow

## Selected candidate-side host

Use **Codex** for this assessment's coding-agent work. Open the repository root as the Codex workspace and trust it only after reviewing the repository contents.

- Root instructions: `/AGENTS.md`
- Task skill: `.agents/skills/papaya-takehome/SKILL.md`
- Codex project defaults: `.codex/config.toml`
- Codex specialist adapters: `.codex/agents/*.toml`
- Technical challenge instructions: `02-devsecops-challenge-1/AGENTS.md`
- Canonical role packs: `02-devsecops-challenge-1/.agents/skills/<role>/`
- Private state: `02-devsecops-challenge-1/ai/WORK-STATE.local.md` (gitignored)
- Execution plan: [CODEX-EXECUTION-PLAN.md](CODEX-EXECUTION-PLAN.md)
- Start prompt: [START-PROMPT.md](START-PROMPT.md)

The employer's use of Claude Code is a **Papaya target-environment scenario fact**, not a requirement to use Claude Code as the candidate's authoring client. Do not configure or maintain a Claude candidate-side adapter for this workflow.

## Start / resume

1. Open the repository root in Codex, not the assessment subfolder.
2. Verify the actual branch, HEAD, working tree, loaded instructions, available skills and custom agents in the running client. File presence alone is not runtime discovery evidence.
3. Complete the harmless native transcript-capture probe in [evidence/CODING-AGENT-CAPTURE.md](../evidence/CODING-AGENT-CAPTURE.md). Export and preserve that real probe session before starting substantive Codex work.
4. Start a **new Codex session** for the assessment work, invoke `$papaya-takehome`, and follow [the execution plan](CODEX-EXECUTION-PLAN.md).
5. Keep the main Codex thread accountable for scope, decisions, integration, edits, verification and final acceptance. Use specialist child agents only for bounded, independent, read-only reviews.
6. Preserve every actual Codex main/child session as a complete raw native export. Record each session and its SHA-256; do not reconstruct or edit exports.

## Load only the context needed for each task

- Load the primary DevSecOps Engineer four-artifact bundle in the main thread.
- Keep Project Manager and Technical Lead responsibilities in the coordinating main thread.
- Load each supporting specialist's four artifacts only when assigning that specialist.
- Do not preload all roles, the full repository or unrelated assessment material.
- Child assignments include requirement IDs, exact source SHA, scope/non-scope, source paths, one decision question and an acceptance oracle.
- Specialist agents are read-only. Only the main thread integrates findings and edits shared deliverables.

## No lab / no practice requirement

Do not create a synthetic cloud environment, deploy sample services, build a practice lab, provision test infrastructure or run a demo deployment for this take-home. Papaya explicitly says system access is neither available nor expected. The submission is a reference design.

It is appropriate to:
- author clearly labelled reference configuration snippets and policy examples;
- validate Markdown links and parse YAML/JSON/TOML syntax locally;
- design proposed positive, negative, performance, resilience and recovery test cases;
- explain what Papaya would verify during its own rollout.

Such static checks and test designs are not production tests, lab results or proof of Papaya implementation.

## Output contract

For each meaningful Codex stage, report:
- stage and status;
- source branch and exact starting/ending SHA;
- specialist agents actually spawned, their bounded assignments and returned findings;
- files created/changed/deleted;
- commands/checks actually run and observed results;
- commit SHA and whether push to GitHub succeeded;
- native session export path(s), SHA-256 and manifest update;
- open unknowns, blockers and one next action.

Never say “updated conversation/config to GitHub” unless the raw native export and configuration were actually committed and read back from the remote repository.
