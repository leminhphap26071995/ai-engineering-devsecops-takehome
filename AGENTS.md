# Repository agent entry

## Purpose
Help produce a truthful, evidence-backed Papaya take-home. The technical deliverable explains how coding agents can support senior DevSecOps engineering without becoming an uncontrolled production authority.

## Host-neutral operating rules
- Use the coding-agent host actually available in the current environment. Do not assume Claude Code, Codex, a model, plugin, MCP server or subagent is installed or enabled.
- The canonical task workflow and professional role packs are host-neutral. Host-specific adapters may invoke them but must not redefine engineering policy or grant authority.
- The checked-in `.codex/` configuration is an available authoring adapter. It is not Papaya's target-state configuration and is not a production security boundary.
- Start from the repository root when using a host that supports repository-level instructions. Verify effective settings and tool permissions instead of inferring them from files.

## Progressive context
- For substantive work, recover the exact goal, employer source, live branch/HEAD, acceptance ledger and first unmet criterion.
- Retrieve only the source files, solution sections and role artifacts required for the current task; do not ingest the whole repository by default.
- Load the accountable primary role's four artifacts. Load supporting specialist packs only when their expertise is actually required.
- Delegate only independent, bounded reviews. A role definition is not proof that a specialist agent was invoked; same-session review is not independent verification.
- On resume, prefer live GitHub source and actual evidence over stale checkpoint summaries.

## Engineering and evidence
- Think across requirements, architecture, implementation, integration, release, operations and recovery.
- Distinguish employer facts, repository observations, recommendations, inference, proposed tests, executed tests, provider observations and owner acceptance.
- Preserve performance, availability, recoverability and developer throughput as first-class quality attributes alongside security.
- Do not invent system topology, SLOs, RTO/RPO, account IDs, cloud claims, test results or runtime capabilities.
- Never access Papaya production systems, credentials or real customer/claim/medical/identity/banking data.
- Never fabricate candidate experience, coding-agent sessions, approvals or submission.
- Preserve raw session exports unedited when required. Do not reconstruct missing logs or silently redact originals.

## Candidate privacy
Candidate-only progress, personal facts and private recovery state do not belong in the submitted repository. Keep private state in the gitignored local file under `02-devsecops-challenge-1/ai/`.

## Writing style
- Write in natural, direct English. Use concrete subjects and verbs instead of slogans or abstract noun phrases.
- Avoid generic AI or consulting language, repeated claims and unnecessary buzzwords.
- Keep technical terms when they name a real mechanism; explain them when the audience may not know them.
- Do not change facts, requirements, security boundaries, evidence status, uncertainty or owner decisions to improve the wording.

## Communication
Lead with the result and evidence. Keep ordinary replies concise; expand when the requested design, code, runbook or audit record requires it.
