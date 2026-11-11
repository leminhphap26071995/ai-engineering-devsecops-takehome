# Personal AI Engineering System Architecture

## Design intent

Use AI as an engineering execution partner while keeping the human accountable for goals, risk, truth, access and acceptance.

`Goal → Requirements → Evidence → Design → Execute → Verify → Record`

## Five logical planes

### 1. Human and Project Control Plane
- Human owner defines outcome, constraints, priorities and acceptance.
- Notion is the mutable project/work board: campaign, ticket, checkpoint, status and next action.
- Project instructions define routing and source authority.
- Human approval remains mandatory for personal claims, sensitive actions and final submission.

### 2. AI Orchestration and Intelligence Plane
- Unified Project Workflow routes intent and recovers project context.
- Context recovery locks the project, ticket, source revision and first unmet acceptance criterion.
- Specialist skills provide domain methods and review criteria.
- Prompt, Loop, Harness, Graph, execution orchestration and verification are reusable capability patterns.
- ChatGPT supports reasoning, research synthesis, requirements and documentation.

A skill is an instruction/method bundle. It does not by itself create an independent worker or enforce host permissions.

### 3. Model and Execution Plane
- OmniRoute is a model/provider routing component; it is not the coding-agent runtime or a security boundary.
- Local Codex is the owner-selected candidate coding-agent runtime for this assessment, subject to client/version, plugin invocation and raw-session capture verification.
- Codex subagents/forks may be used only when actual invocation and complete transcript evidence can be preserved; otherwise keep work in one session.
- GitHub and Notion connectors are adapters to source systems; connector availability does not prove complete provider access.

### 4. Source, CI/CD and Verification Plane
- GitHub owns versioned files, branches, commits, PRs and workflow receipts.
- CI runs requirement-derived checks on exact source revisions.
- Tests and review findings are linked to the revision they evaluate.
- Human review decides whether evidence is sufficient for acceptance.

### 5. Evidence and Continuity Plane
- Raw coding-agent transcripts are stored unchanged.
- Evidence manifest maps sessions to task, branch, commit and changed files.
- CI logs, test output, source links and review decisions are recorded.
- Notion checkpoint stores mutable progress and the single next action.
- Chat history is a convenience, not canonical project state.

## Cross-cutting controls

Least privilege; explicit authorization; privacy and data minimization; source provenance and revision pinning; human accountability; honest capability states; visible UNKNOWN/FAILED states.

## Trust boundaries

1. Human ↔ AI: the model may propose; the human owns authorization and personal truth.
2. Orchestrator ↔ provider tools: only documented connector actions and granted permissions are available.
3. Model routing ↔ coding runtime: inference selection does not confer filesystem, GitHub or cloud authority.
4. Coding agent ↔ repository: agent changes are reviewed as source diffs.
5. Source ↔ CI: checks are tied to exact commits; green CI does not prove production behavior.
6. Evidence ↔ acceptance: evidence supports a decision but does not automatically make it.

## Status

This is a design-level synthesis. Existing repositories/plugin artifacts do not establish a single integrated runtime, fresh-host behavior, independent multi-agent execution or universal host-level enforcement. See [current state](CURRENT-STATE-AND-LIMITATIONS.md).
