---
name: papaya-takehome
description: Host-neutral workflow for producing both Papaya assessments with truthful evidence and a practical AI-assisted DevSecOps engineering design.
---
# Papaya Take-home — main task workflow

## Mission and boundaries
Deliver both assessment parts in one repository that is ready for review, including at least five Logical Question answers (Q1 and Q5 mandatory and based only on candidate-supplied facts) and a human-reviewable DevSecOps Challenge 1 reference design. Preserve every actual coding-agent session as a complete, raw, unedited and shareable native export. This is candidate-side authoring, not Papaya production implementation.

- Use whichever coding-agent host is actually available and approved in the current environment.
- Do not make the solution depend on one vendor's prompt syntax, subagent model, MCP implementation or permission UI.
- Host adapters are optional integration details. The shared requirements, engineering method, role boundaries and evidence rules remain portable.
- The employer brief names Claude Code Team Premium as a scenario fact. Preserve that fact when describing Papaya's stated environment; do not turn it into a requirement that this candidate author with that product.
- GitHub contains versioned assessment sources, deliverables, non-secret authoring configuration and shareable evidence.
- Candidate-only progress, personal facts and private recovery state do not belong in the submitted repository. Keep private progress in the gitignored local file `02-devsecops-challenge-1/ai/WORK-STATE.local.md`.

## Source lock
- Logical Questions README: `8411c5a085740700b45adfc6bf3fd022eb96f3a1`.
- DevSecOps Challenge 1 + Appendix A: `4eae49e24c9ba3c59102c0149b70b601d830002a`.
- AI Engineering guide: `da8e65b4679844b53bf0fb000cbb330e970b1842`; its three-point catalogue rule is not the DevSecOps Challenge 1 acceptance.
- Employer/HR clarifications are source evidence only when the exact communication is available; distinguish them from public source wording.

## Start / resume
1. Verify live branch, HEAD, working-tree state and exact employer source revision.
2. If the selected host's native capture/export path has not been proven, run a harmless capture probe and inspect completeness/shareability before substantive coding-agent sessions. If the employer requires raw exports and the selected host cannot provide them, record the blocker honestly; do not invent a substitute.
3. Identify the active assessment part and first unmet employer MUST/gate.
4. For Logical Questions, complete at least five answers: Q1 and Q5 are mandatory and must use candidate-provided facts; select at least three additional questions from the exact employer source. Retrieve only the employer source, acceptance rows and deliverable sections needed for that work.
5. For a new goal or changed scope, establish the requirement baseline and architecture/dependency map before implementation.
6. Load the accountable primary role's four artifacts. Load a supporting specialist's four artifacts only when assigning that role.
7. Give any delegated reviewer a clear brief: goal/requirement IDs, exact SHA, scope/non-scope, source paths, decision question, expected output and how the work will be checked.
8. Keep the main session responsible for goal, decisions, integration and final acceptance.

## Technical challenge — role routing
- Project Manager: source lock, scope, stable requirement IDs and acceptance ledger.
- Technical Lead: system boundaries, interfaces, dependencies, decomposition and architecture conflicts.
- DevSecOps Engineer: accountable primary for integrated secure-delivery design and senior DevSecOps engineering reasoning.
- AI Agent Security: coding-agent runtime, prompt injection, tool abuse, identity, secrets, egress and containment.
- AI Native: production AI workload lifecycle, model/tool/data flow, evaluation and tenancy.
- DevOps: CI/CD, cloud identity, IaC ownership, artifacts, deployment, HA/DR and operations.
- Security Assurance: control applicability, privacy boundaries and audit evidence; not legal sign-off.
- QA: positive, negative, boundary, bypass and recovery tests based on the requirements.

Do not spawn every role for ceremony. Delegate only decisions that are reviewable separately and important to the outcome.

## Engineering method
For each task, the agent should:
1. Understand the desired outcome, system context, constraints and acceptance.
2. Inspect the actual repository/system state and trace affected dependencies before proposing changes.
3. Establish baseline behavior and relevant performance/reliability signals when available.
4. Identify failure modes, threats, blast radius, data classification and authorization boundaries.
5. Compare viable options and explain security, performance, reliability, cost and operational trade-offs.
6. Produce an implementation plan with clear scope with rollback and verification.
7. Make only authorized changes; never infer permission to mutate production.
8. Verify functional, security, performance and operational acceptance against observable evidence.
9. Record unresolved assumptions, residual risks and the exact evidence needed next.

## Hard truth boundaries
- Use synthetic/sanitized examples only. Never access Papaya production systems, credentials or real customer/claim/medical/identity/banking data.
- Distinguish employer facts, candidate-provided facts, repository observations, recommendations, inference and unknowns.
- Proposed tests are not executed tests. A role file is not an agent invocation. A committed host config is not proof of effective runtime permissions.
- Never claim Papaya implementation, audit, certification, legal compliance or tests that were not run.
- Never fabricate candidate experience, personal facts, session exports, owner approval or submission.

## Source map
- Logical Questions: `01-logical-questions/`; read exact employer wording and only the candidate answer being edited.
- DevSecOps requirements: `02-devsecops-challenge-1/solution/requirements-and-acceptance.md`.
- Main technical output: `02-devsecops-challenge-1/solution/PROPOSAL.md`.
- AI task reasoning: `02-devsecops-challenge-1/solution/ai-assisted-devsecops-workflow.md`.
- Shared workflow: `02-devsecops-challenge-1/system/`.
- Role packs: `02-devsecops-challenge-1/.agents/skills/<role>/`.
- Host adapter inventory: `02-devsecops-challenge-1/AI-CONFIGURATION.md`.
- Session evidence: `02-devsecops-challenge-1/evidence/`.

## Recovery and closeout
On context loss, recover the original goal, current live source/ref/SHA, acceptance ledger and first unmet criterion. Reconstruct original goal → MUST → expected behavior → gate → actual action → observed result. Continue at the first unmet criterion. Maintain one testable hypothesis per failure branch; change the evidence route after uninformative retries.

After significant work, update only private local state and required submission evidence. Preserve raw exports byte-for-byte. Never commit local candidate progress, private correspondence, unrelated personal information or internal task-tracker identifiers. Never mark complete while an employer MUST or owner-only gate remains open.
