# Papaya DevSecOps operating model for coding agents

The system is **host-neutral**. Coding-agent products are replaceable execution interfaces; the engineering method, role ownership, evidence contract and external authorization boundaries are the stable core.

## Main parts

| Layer | Location | Purpose |
|---|---|---|
| Repository bootstrap | root `AGENTS.md` | Minimal routing, safety and context rules |
| Task workflow | root `.agents/skills/papaya-takehome/` | Source lock, assessment gates, role routing and recovery |
| Host adapters | root `.codex/` and other supported adapters when present | Host-specific project settings and specialist invocation |
| Role expertise | `../.agents/skills/<role>/` | Four-artifact professional method bundles |
| Private work-state | `../ai/WORK-STATE.local.md` | Gitignored candidate-only recovery cursor |
| Shared system | this directory | Accountability, role catalogue, gates and sequence |
| Engineering deliverable | `../solution/PROPOSAL.md` | Reviewer-facing reference architecture |
| AI execution method | `../solution/ai-assisted-devsecops-workflow.md` | Task intake through operational acceptance |
| Evidence | `../evidence/` | Session exports, capture and verification |

## How to use this workspace
1. Recover the exact task, employer source, live source revision and first unmet acceptance criterion.
2. Verify the selected host's effective tools/permissions and required native session capture before substantive work.
3. For a new or changed goal, establish requirements, constraints, system boundaries and acceptance before implementation.
4. Load the DevSecOps Engineer primary role for integrated engineering work.
5. Load AI Agent Security, AI Native, DevOps, Security Assurance or QA only when the task requires their distinct expertise.
6. Keep the main session responsible for decisions and integration; delegate only independent reviews with a clear scope.
7. Verify functional, security, performance, resilience and operational outcomes; preserve actual evidence and unknowns.

## Engineering responsibilities and coding-agent support
- **Engineering team and systems:** infrastructure, cloud, CI/CD, application delivery, security, performance, reliability, HA/DR, observability, incident response and cost.
- **Coding-agent support:** task understanding, context retrieval, system discovery, specialist routing, option analysis, limited actions, verification and evidence.
- Coding agents help with engineering work. They do not replace the engineer's accountability or gain permission just because a prompt asks them to perform an action.

## Evidence
A role bundle is a method definition, not a role invocation or competency credential. A proposed control/test is not an executed control/test. Host configuration is not proof of effective permissions. Same-session critique is not independent review.
