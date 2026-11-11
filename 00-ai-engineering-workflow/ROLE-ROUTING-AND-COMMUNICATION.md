# Papaya Role Routing and Communication Contract

## Source lock

The candidate repository pins Unified Project Workflow Codex plugin v0.1.97 at:
- Repository: `leminhphap-improvement/ai-workflow-archtiecture`
- Commit: `fd981a03839566875146e9c853b52861db63396d`
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

## Concise communication standard

Target: senior-level judgment explained in language a non-specialist can understand.

Every answer should contain only the fields that matter:
1. **Answer/decision:** answer the question first.
2. **Problem:** what is wrong or what risk matters?
3. **Solution:** what should change and why?
4. **Trade-off/improvement:** include only the material cost, limitation or next improvement.

Rules:
- Keep normal replies short: one direct paragraph or a few bullets; use a compact table only when comparing options.
- Do not write an essay, repeat the prompt, narrate internal role orchestration or dump role inventories.
- Preserve correct technical terms. Explain a new term briefly in plain language on first use.
- Use the user's language by default; keep product names, standards, protocol names and canonical technical terms unchanged.
- Distinguish source fact, owner report, inference and unknown. Never compress away uncertainty.
- Expand only when the task requires a complete technical artifact, threat model, architecture or evidence record.

## Context compiler contract

The proposed Python utility is a context compiler, not a replacement for source documents or model judgment.

- Preserve original human input, employer requirements and raw agent transcripts unchanged.
- Produce a compact, language-tagged, source-linked context envelope containing goal, requested outcome, scope/non-goals, MUST acceptance criteria, constraints, decisions, relevant evidence, unknowns and one next action.
- Use deterministic Python for parsing, deduplication, metadata, hashes, reference extraction, retrieval and schema/token-budget validation.
- Use the model for semantic normalization/summarization. Plain Python cannot reliably understand arbitrary languages or preserve intent by itself.
- Every compressed requirement must retain its source reference. Never silently remove negation, numbers, dates, identifiers, thresholds, security constraints, owner decisions or conflicts.
- Retrieve the original passage when nuance is consequential. If mandatory context exceeds budget or conflicting requirements cannot be reconciled, fail visibly; do not truncate silently.
- Generate the answer from the validated envelope, then validate structure/length and render in the user's language while preserving technical terminology.
- Summaries are derived working views. The original source remains authoritative.

