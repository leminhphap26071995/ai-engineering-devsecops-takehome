# DevSecOps Challenge 1 — AI-assisted DevSecOps engineering

## Start here
Read the [integrated proposal](solution/PROPOSAL.md), followed by the [AI-assisted DevSecOps workflow](solution/ai-assisted-devsecops-workflow.md). The [solution index](solution/README.md) links to the threat model, architecture, coding-agent controls, delivery workflow, cloud and data protection, operations, decisions, diagrams and references.

## How to read this solution
This is not simply a policy for locking down a coding assistant. It defines how a senior DevSecOps engineer can use an available coding agent across the engineering lifecycle:
- discover and understand an existing system before changing it;
- reason about architecture, security, performance, availability, cost and operability together;
- use a coding agent to analyse systems, prepare changes, automate repeatable tasks and organize evidence;
- keep production authority, approvals and irreversible actions under independent controls;
- verify the actual system outcome rather than accepting plausible text or valid configuration syntax.

## Coding-agent setup
The canonical task workflow and professional role packs are host-neutral. The employer's scenario names Claude Code Team Premium as Papaya's primary coding agent; Claude-specific controls in the solution describe Papaya's target environment, not a candidate-side adapter. This repository revision contains a Codex authoring adapter only.

For candidate-side work, open the **repository root** as the Codex workspace so root `AGENTS.md`, `.agents/skills/` and `.codex/` are discovered. Do not open this assessment subfolder as a separate Codex workspace. See [AI configuration](AI-CONFIGURATION.md).

- [Private work-state template](ai/WORK-STATE.template.md) — copy locally to the gitignored private file; never submit personal progress state.
- [AI workspace guide](ai/README.md) — progressive context and role loading.
- [Troubleshooting](ai/TROUBLESHOOTING.md) — host/instruction/skill recovery.
- [System overview](system/README.md) — operating model, role boundaries and gates.
- [Role packs](.agents/skills/) — senior DevSecOps primary and supporting disciplines.

## Evidence
The [evidence index](evidence/README.md) separates conversation links, native coding-agent session exports, capture status and verification. Preserve raw native exports byte-for-byte only after completeness and shareability are verified.

## Scope boundary
This is a candidate-side reference design based on the employer's written scenario. It is not access to or implementation of Papaya systems. No Papaya production credentials or real customer, claim, medical, identity or banking data may enter this workspace.
