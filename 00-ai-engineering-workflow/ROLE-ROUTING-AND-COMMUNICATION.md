# Papaya Role Routing and Communication Contract

## Source lock

The candidate repository pins Unified Project Workflow Codex plugin v0.1.98 at:
- Repository: `leminhphap-improvement/ai-workflow-archtiecture`
- Commit: `7b19d78bd3db8091d5ab5aa827031c60065e49bc`
- Plugin path: `plugin/overlay`

The pinned package contains six complete role bundles (each with `SKILL.md`, `mindset.md`, `knowledge.md`, `workflow.md`):
1. `ai-native-tooling-engineer`
2. `devops-engineer`
3. `professional-capability-architect`
4. `qa-engineer`
5. `security-reviewer`
6. `software-architect`

This is source-level availability in the pinned package. It does not prove installation, activation or invocation in the owner's Codex host.

## Selected roles for Challenge 1

Use exactly four role bundles across the challenge, loaded only when their workstream is active:

| Role | Assignment | Owns |
|---|---|---|
| `software-architect` | Accountable primary | Overall coding-agent framework, system boundaries, lifecycle, architecture decisions and trade-offs |
| `security-reviewer` | Security specialist | Threat model, agent/tool trust boundaries, prompt injection abuse cases, IAM, secrets, sensitive data, MCP/plugin risk and residual risk |
| `devops-engineer` | Delivery specialist | CI/CD, build/artifact provenance, deployment gates, OIDC handoff, rollback and operational evidence |
| `qa-engineer` | Acceptance reviewer | Requirement-derived positive/negative/boundary tests, bypass cases, regression and evidence-based acceptance |

### Loading order

- Start with `software-architect` as the only full role bundle for requirements-to-design.
- Load `security-reviewer` when threat model, permissions, data or tool abuse is being designed/reviewed.
- Load `devops-engineer` for CI/CD, release, cloud deployment and rollback sections.
- Load `qa-engineer` for test design and final adversarial acceptance.
- Keep one accountable primary. A reviewer perspective in the same Codex session is not an independent worker or independent QA.
- Do not load all four bundles into every prompt. Load only the current role's four artifacts and the minimum shared UPW contracts needed for that phase.

### Explicit exclusions

- Do not claim that `devsecops-engineer`, `cloud-engineer` or `ai-native-engineer` is included in this pinned Codex package; those role bundles are absent from its source tree.
- `ai-native-tooling-engineer` is available but not selected by default: its scope is AI tool/plugin/MCP discovery and lifecycle, not the overall agent-security architecture. Invoke it only if actual installation, integration or lifecycle work becomes a deliverable.
- Do not add PM, BA, generic DevOps, SRE, Backend, Frontend or other roles without a newly identified deliverable that requires that discipline.
- If a genuinely missing specialty becomes necessary, use UPW professional-capability discovery and create a task-scoped four-artifact profile; do not silently substitute a similarly named role.

## Logical Questions

No engineering role is required. Use the career/interview workflow only for answer structure and clarity. The owner supplies personal facts for Q1 and Q5; AI must not invent autobiographical content.

## Concise communication contract

For ordinary human-facing answers:
1. State root cause when one exists.
2. State the solution.
3. Add only one relevant concern:
   - Trade-off: a material cost or limitation of the chosen option.
   - Prevention: a control for recurrence, security or reliability risk.
   - Improvement: a concrete future optimization that remains.
4. Omit irrelevant categories; do not force all three.
5. Use natural prose, no unnecessary headings/labels, no exaggerated or agentic wording, up to five sentences and a target of 20–30 whitespace-separated units. Never truncate required meaning.
6. Preserve technical terms, identifiers, numbers, negation, conditions, evidence status and uncertainty. Full technical artifacts are exempt.
7. Use Vietnamese when the owner writes Vietnamese; retain standard English technical terms and explain unfamiliar concepts simply.

## Two-way language bridge

The project-local implementation is scripts/language_bridge.py. The main flow is prepare → read the validated context → execute → write the structured answer to the outbox → finalize. Python handles hashes, schemas, exact-token checks and file routing; Codex helper sessions perform semantic normalization and translation.

Language selection is model-specific. auto uses only a VERIFIED benchmark profile for the exact model ID; without one, it keeps the source language. Do not assume English is universally optimal.

The current script handles raw request text, not arbitrary source-file parsing or source retrieval. The main agent must inspect authoritative sources. Seven unit tests pass with a mocked helper; live Codex execution and transcript capture remain unverified.

Each prepare/finalize call starts a separate Codex exec session. Its event JSONL is not a native conversation export. Do not use the bridge for Papaya assessment work until the harmless capture probe confirms every helper session can be captured completely and shared safely. Otherwise, keep the main agent in the source language.


## Codex-specific role and custom-agent configuration

Codex discovers the project-local role skills from `.agents/skills/` and custom subagents from `.codex/agents/`. The project-scoped defaults are in `.codex/config.toml`. These files are source configuration only; local trust, plugin installation, skill discovery and actual invocation must be verified on the owner's Codex client.

### Five complete role bundles available in this project

The selected four Challenge 1 role bundles are mirrored from UPW v0.1.98 at canonical source commit `7b19d78bd3db8091d5ab5aa827031c60065e49bc`. Each has all four artifacts: `SKILL.md`, `mindset.md`, `knowledge.md`, `workflow.md`. Provenance and source blob IDs are recorded in `.agents/skills/role-pack-provenance.json`.

| Project skill | Responsibility | Codex use |
|---|---|---|
| `software-architect` | Accountable primary for Challenge 1 | Main Codex thread; invoke `$software-architect` |
| `role-security-reviewer` | Threat model, agent/tool trust, IAM, secrets, data and supply chain | Spawn `security_reviewer` when security phase is active |
| `role-devops-engineer` | GitHub Actions, Pulumi/Serverless, OIDC, deployment, rollback and operations | Spawn `devops_engineer` when delivery phase is active |
| `role-qa-engineer` | Requirement oracles, positive/negative/boundary/bypass acceptance | Spawn `qa_engineer` during verification |
| `ai-native-tooling-engineer` | Codex/plugin/skill/custom-agent setup and consumer activation | Conditional setup role; not part of the four Challenge 1 roles |

### Custom-agent boundaries

- Supporting custom agents are read-only and inherit the parent model/provider. No model is pinned because the actual local Free-account availability and chosen model must be recorded from the session.
- The project config allows up to three concurrent supporting threads. Invoke the AI Native Tooling Engineer separately when setup work is active.
- The main thread remains accountable and integrates findings; custom agents do not independently approve or submit the assessment.
- A role bundle is a professional method. A custom-agent definition is an invocation adapter. Only an actually spawned agent counts as a conversation/session and must be captured in the transcript manifest.
- Do not claim a custom agent or role skill was invoked from the presence of its TOML/Markdown files.

### Exact skill loading

Each project-local `SKILL.md` directs Codex to read its sibling `mindset.md`, `knowledge.md` and `workflow.md`. The parent prompt should explicitly invoke the relevant skill and spawn only the supporting agent needed for the current phase. Do not load all role bundles into every prompt.

Logical Questions do not use engineering roles. Q1 and Q5 remain owner-fact-only; the remaining three answers must be selected after checking the exact source question wording.


## Task-specific Codex orchestrator

The project-local skill `$papaya-takehome` is the assessment orchestrator. It preserves the two-part acceptance, owner-fact boundaries for Q1/Q5, source references, challenge-specific role order, transcript gate and one-repository submission contract. Invoke it only after the harmless Codex capture probe passes. It does not replace the UPW universal guard or any of the specialist four-artifact role bundles.
