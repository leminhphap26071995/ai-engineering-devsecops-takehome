# DevSecOps Challenge 1 — folder-specific rules

The repository-root `AGENTS.md` is the shared entry contract and is loaded first. This file adds only this assessment folder's scope.

- Human-facing technical deliverable: `solution/PROPOSAL.md`; read its source/acceptance index before changing a control.
- Shared workflow and role ownership: `system/README.md`, `system/role-catalog.md`, `system/gates.md`.
- Canonical role packs remain in `.agents/skills/<role>/`; load only the active primary or assigned reviewer.
- Resume from the gitignored `ai/WORK-STATE.local.md`, created from `ai/WORK-STATE.template.md`; do not commit it.
- Codex execution plan and start prompt are `ai/CODEX-EXECUTION-PLAN.md` and `ai/START-PROMPT.md`.
- Configuration inventory is `AI-CONFIGURATION.md`; evidence inventory is `evidence/README.md`.
- No candidate lab, practice environment, cloud deployment or demo service is required. Proposed Papaya rollout tests are not candidate test results.
- Do not assume that this folder is the Codex project root. Start Codex from the repository root so root instructions, skills and custom agents are discovered.
- All Papaya privacy, capture, source and owner-approval boundaries in the root task skill remain mandatory.
