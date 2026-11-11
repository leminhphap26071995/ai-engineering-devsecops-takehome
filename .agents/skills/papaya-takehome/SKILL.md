---
name: papaya-takehome
description: Execute the two-part Papaya DevSecOps take-home in this repository using the pinned UPW workflow, specialist roles, source-grounded design, owner-fact safeguards and complete AI conversation/configuration evidence. Use only after the harmless Codex transcript-capture gate has passed.
---

# Papaya Take-home — Codex Execution Skill

## Hard precondition

Do not begin substantive assessment work until the owner has completed the harmless local Codex capture probe and verified that the resulting complete conversation export is safe and acceptable to share. If the raw rollout contains provider-internal instructions or sensitive content, stop and obtain an HR-acceptable export format. Never silently redact or reconstruct a raw transcript.

Do not use `scripts/language_bridge.py` for assessment content until every helper session can also be captured completely and safely. Prefer the main Codex session in the user's source language.

## Goal and immutable acceptance

Deliver one reviewer-ready GitHub repository containing both Papaya assessment parts and all assessment-relevant AI conversation/configuration evidence.

1. Logical Questions: at least five answers; Q1 and Q5 are mandatory and based only on owner-supplied personal facts. Select at least three additional questions after reading the exact employer source and confirming the owner's preference. Never invent autobiographical content.
2. DevSecOps Challenge 1: complete source-grounded candidate reference design for coding-agent governance and secure DevSecOps delivery. Include problem/requirements, threat model, trust boundaries, architecture, agent/tool policy, CI/CD and production workflow, cloud/data protection, compliance mapping, observability/incident response, rollout, residual risks and acceptance.
3. Use a genuine coding agent. Preserve every coding-agent session actually used as a complete, raw, unedited, acceptable conversation export.
4. Include all assessment-relevant AI conversations actually used, not unrelated personal chats. Include non-secret AI configuration used for those conversations.
5. Both assessments, accepted conversation exports, configuration evidence and reviewer-friendly README must live in this one repository.
6. No credentials, secrets, provider-internal instructions, private personal data, customer/claim/medical/identity/banking data.
7. Owner reviews all claims, personal answers, transcripts, repository access and final wording. Do not send HR email or claim submission without explicit owner approval.

## Source authority

- Challenge 1: `Hiring/DevSecOps_Challenges/DevSecOps_Challenge_1.md`, Papaya Pumpkin source blob `4eae49e24c9ba3c59102c0149b70b601d830002a`.
- AI Engineering guidance: `Hiring/AI_Engineering_Challenges/README.md`, source blob `da8e65b4679844b53bf0fb000cbb330e970b1842`.
- Logical Questions: `Hiring/Logical_Questions/README.md`, source blob `8411c5a085740700b45adfc6bf3fd022eb96f3a1`.
- Submission repo: `leminhphap26071995/ai-engineering-devsecops-takehome`.
- Candidate-side UPW Codex plugin: v0.1.98 from `leminhphap-improvement/ai-workflow-archtiecture@7b19d78bd3db8091d5ab5aa827031c60065e49bc`.
- HR clarification is owner-reported on 2026-11-11: upload assessment-related AI conversations and AI configurations; existing repository name may be retained if all requirements are met.

Re-read the exact sources from the current checked-out repository before changing their interpretation. The employer says the candidate has no access to Papaya systems and does not expect access. This is a candidate design, not Papaya implementation, audit or certification.

## Professional role routing

Use one accountable primary and load supporting roles only when their phase is active.

- Main Codex thread: `$software-architect` — overall requirements, architecture, lifecycle, boundaries and trade-offs.
- Spawn `security_reviewer` after the primary has scoped assets/trust boundaries; invoke `$role-security-reviewer` and read all four artifacts.
- Spawn `devops_engineer` for delivery, GitHub Actions, Pulumi/Serverless, OIDC, deployment gates, rollback and operations; invoke `$role-devops-engineer` and read all four artifacts.
- Spawn `qa_engineer` for requirement oracles, positive/negative/boundary/bypass tests and final acceptance; invoke `$role-qa-engineer` and read all four artifacts.
- `ai_native_tooling_engineer` / `$ai-native-tooling-engineer` is conditional for Codex/plugin/skill/custom-agent setup only; it is not a fifth Challenge 1 design role.

The local role skills are under `.agents/skills/`; every `SKILL.md` requires reading sibling `mindset.md`, `knowledge.md` and `workflow.md`. Custom-agent TOML files are under `.codex/agents/`. A role definition is not proof of a spawned agent. Record every actually spawned subagent as a separate AI conversation and capture its native transcript.

Do not use a generic DevOps/Architect role as a substitute for missing security or QA work. Do not claim independent QA from a same-session perspective.

## Challenge 1 source-aligned design constraints

- Papaya's developer coding agent is Claude Code Team Premium; the candidate's Codex is only the assessment tool. Keep these two contexts distinct.
- Separate developer coding agents from production claim/document/FWA AI agents, with distinct identities and trust boundaries.
- Preserve the employer's stated stack: GitHub monorepo, GitHub Actions, Pulumi and Serverless Framework, AWS, GCP Vertex/Gemini, k0s and Firebase Hosting; Node.js/TypeScript, Apollo/Hasura, PostgreSQL, Next.js/React, React Native/Expo and Python/PyTorch/OpenAI/Vertex/Gemini/Claude.
- Do not assume Terraform is the existing IaC system or add it solely because the environment is multi-cloud.
- Explicitly address developer AWS SSO profiles that can reach production, disabled permission prompts, unreviewed MCP/plugins, long-lived GitHub/AWS credentials, fragmented monitoring, informal on-call, Firebase preview isolation and sensitive insurance data.
- Enforce privileged actions outside the model. Agent autonomy in an isolated development environment must not become production authorization.
- Named human approval is required for every production change, bound to the exact commit and environment. Cloud IAM must prevent bypass through direct provider APIs.
- Do not assume Claude Team Premium provides HIPAA BAA coverage for PHI. Default to synthetic/sanitized data unless eligible product surface and contract are verified.
- Map ISO 27001, HIPAA and regional privacy objectives to controls/evidence without claiming certification or legal conformity.

## Work sequence

1. Recover the exact repository branch/HEAD, open PR, source documents and acceptance ledger. Inspect existing artifacts before drafting or editing.
2. Primary software architect maps every employer requirement to deliverable, control, owner, consumer and acceptance oracle.
3. Security reviewer challenges identity, permissions, prompt injection, tool supply chain, sensitive data and bypass paths.
4. DevOps engineer challenges source-to-production, CI, artifact provenance, OIDC, approval, rollback and observability.
5. Primary integrates findings and resolves disagreements with source evidence; record dissent and decisions.
6. QA engineer creates the requirement-derived acceptance matrix and adversarial counterexamples.
7. Update the actual design documents in coherent batches. Do not one-shot the entire deliverable or blindly accept model output. Inspect, critique, revise and explain material choices.
8. For Logical Questions, re-read exact wording. Q1 and Q5 require owner facts. Confirm the three optional questions before drafting. Answers must explain why and preserve the owner's natural voice.
9. Inventory all assessment-relevant AI conversations, actual skills/custom agents used, effective non-secret configurations and project instruction/config hashes.
10. Verify every transcript is complete, acceptable and unedited; check secrets/PII; verify links, repository visibility and one-repository completeness.
11. Ask the owner to review personal answers, technical claims, transcripts and final repository. Stop before HR submission unless explicitly authorized.

## Evidence and reporting

Distinguish SOURCE_VERIFIED, OWNER_STATED, TOOL_OBSERVED, INFERRED and UNKNOWN. A source file or custom-agent config is not proof of local installation/invocation. A test design is not an executed test. A green repository check is not transcript acceptance or owner submission approval.

Use:
- `03-ai-agent-evidence/AI-CONFIGURATION-MANIFEST.md`
- `03-ai-agent-evidence/session-manifest.md`
- `03-ai-agent-evidence/CODEX-CAPTURE.md`

Do not mark the task ready while any employer MUST, required conversation, configuration record, privacy review, repository access or owner acceptance remains open.
