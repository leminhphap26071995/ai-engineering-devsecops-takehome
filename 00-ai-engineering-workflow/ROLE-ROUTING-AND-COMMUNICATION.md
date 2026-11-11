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
