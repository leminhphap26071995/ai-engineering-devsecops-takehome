# Codex execution plan — Papaya DevSecOps Challenge 1

## Goal

Complete the candidate-side reference design for the employer's request:

> Design the framework and workflow for how Papaya uses coding agents for DevSecOps.

This is a **documentation, architecture and reference-configuration deliverable**. It is not a request to build an agent platform, application, cloud environment, synthetic lab or practice deployment. Papaya system access is explicitly unavailable and not expected.

## Scope and non-goals

### In scope
- Clarify the employer requirements and map each to design controls, enforcement points, accountable owners, proposed tests and evidence.
- Make the AI-assisted engineering workflow concrete enough that a senior engineer can direct a coding agent on real tasks.
- Use the DevSecOps Engineer as the accountable primary role.
- Ask specialists to review agent security, production AI workloads, DevOps delivery/operations, security assurance and QA within clearly defined scopes.
- Provide version-verified, clearly labelled reference configuration examples where they materially improve implementability.
- Verify document navigation, configuration syntax and requirement traceability.
- Preserve every actual Codex session as a complete raw native export.

### Explicitly out of scope
- No Papaya production access, credentials, data or system changes.
- No cloud account/project creation, IaC apply, cluster deployment, Firebase deployment or live GitHub Actions deployment.
- No synthetic cloud lab, practice environment, demo application, benchmark environment or game day for this candidate submission.
- No invented SLO, RTO, RPO, account IDs, repository paths, IAM principals, legal applicability or production topology.
- No claim that proposed Papaya tests were executed.
- No Claude candidate-side adapter. Claude Code remains a fact about Papaya's stated environment, not this candidate's authoring host.

## Who is responsible

| Role / execution surface | Accountability | May do | Must not do |
|---|---|---|---|
| Codex main thread — Project Manager coordination | Goal and source version, scope, acceptance checklist, sequencing and checkpoint | Recover sources, assign work, resolve priority and track every MUST | Replace specialist decisions with generic assumptions |
| Codex main thread — Technical Lead coordination | System boundaries, interfaces, architecture conflicts and integration | Reconcile specialist findings and own integrated design | Claim independent specialist review |
| Codex main thread — DevSecOps Engineer (primary) | Complete engineering outcome and final technical integration | Load four-artifact primary pack; design and edit the integrated proposal, matrix, diagrams and reference configs; verify and commit | Delegate away accountability or approve production changes |
| `ai_agent_security_engineer` child | Coding-agent runtime, prompt injection, tools/MCP, identity, secrets, egress and containment | Read-only attack-path review with enforcement and bypass tests | Edit files, grant permissions or approve residual risk |
| `ai_native_engineer` child | Production claims/document/FWA AI workload and data/tenant lifecycle | Read-only data-flow, tool authorization, evaluation, isolation and failure review | Conflate production AI agents with developer coding agents |
| `devops_engineer` child | GitHub Actions, cloud identity, Pulumi/Serverless ownership, artifact flow, performance, HA/DR and operations | Read-only pipeline/platform feasibility review | Change IaC ownership or claim provider behavior was executed |
| `security_assurance_engineer` child | ISO/NIST/OWASP control mapping, privacy and audit evidence | Read-only applicability and evidence review; identify legal/privacy owner decisions | Give legal advice or claim certification/compliance |
| `qa_engineer` child | Requirement mapping and testable acceptance criteria | Read-only adversarial review of positive, negative, boundary, bypass and recovery tests | Convert proposed tests into results or approve its own design |

The main thread is the only writer. Specialist child agents are read-only and return findings supported by source evidence. Same-session child reviews are specialist perspectives, not independent human verification.

## Execution sequence

### Stage 0 — Native Codex capture gate
1. Start a harmless, read-only Codex capture-probe session using the exact prompt in `evidence/CODING-AGENT-CAPTURE.md`.
2. Export that native session using the actual Codex client's supported mechanism.
3. Verify that the export is complete, readable and shareable without altering the original.
4. Record product/client/version, model, session ID, file size and SHA-256.
5. Do not start substantive Codex work until this gate is satisfied. If no compliant native export is available, stop substantive Codex work and report the blocker.

### Stage 1 — Requirement and source baseline
Main thread loads:
- root `AGENTS.md`;
- `.agents/skills/papaya-takehome/SKILL.md`;
- `02-devsecops-challenge-1/AGENTS.md`;
- `solution/requirements-and-acceptance.md`;
- `solution/problem-and-scope.md`;
- `solution/PROPOSAL.md`;
- `system/role-catalog.md`, `system/gates.md`;
- the primary DevSecOps four-artifact role pack.

Record exact employer source revision, repo branch/HEAD, working tree, every E/D requirement and first unmet criterion.

### Stage 2 — Specialist reviews

Use at most two read-only child agents concurrently, consistent with the checked-in Codex configuration.

**Wave A**
- `ai_agent_security_engineer`: D-01, D-02, D-03, D-05 and coding-agent attack paths.
- `ai_native_engineer`: D-09, D-10 and production AI data/tool/tenant boundaries.

**Wave B**
- `devops_engineer`: D-04, D-05, D-06, D-07, D-08 plus CI/CD, AWS OIDC, GCP WIF, Pulumi/Serverless, performance, availability, HA/DR and recovery.
- `security_assurance_engineer`: privacy/data protection, ISO 27001/HIPAA/regional applicability boundaries, control evidence and owner decisions.

Each assignment must include:
- exact requirement IDs and source SHA;
- clearly limited source paths and explicit scope/exclusions;
- one or more concrete decision questions;
- expected output: finding, evidence/source, control/enforcement point, negative test, trade-off, unknown and residual risk;
- no-edit/read-only constraint.

Wait for each assigned reviewer and inspect its actual returned result. If Codex does not spawn the requested agent, report `NOT SPAWNED`; do not claim that role ran.

### Stage 3 — Integrate findings and update the design
The DevSecOps primary integrates specialist findings and implements one coordinated documentation/configuration update:

1. Complete the requirement-to-control matrix for E-01..E-06 and D-01..D-10.
2. Ensure every D requirement maps to an enforcement point, accountable owner, proposed test and observable evidence.
3. Add reference-only examples where useful: GitHub Actions least-privilege validation and protected deployment, AWS OIDC trust constraints, GCP WIF attribute conditions, CODEOWNERS/protected path policy, reviewed tool/plugin inventory, and runtime/data authorization examples.
4. Label every placeholder, assumption, provider-specific version and unknown. Do not invent Papaya account names, repository paths, project IDs, stack names or SLO values.
5. Strengthen performance, developer throughput, reliability, HA/DR, restore/failover and operational acceptance without introducing unnecessary gateways or serial hot-path dependencies.
6. Keep the proposed design host-aware: Codex config in this repository is the candidate authoring adapter; it is not Papaya's deployed Claude Code or production policy configuration.
7. Update proposal, architecture, secure-delivery workflow, rollout/assurance, solution index and diagrams so they tell one consistent story.

Do not implement a real Papaya pipeline or cloud resource. Reference snippets are illustrative, not deployable without organization-specific values and review.

### Stage 4 — QA review and fixes
Spawn `qa_engineer` as a read-only reviewer after the primary integration. Require it to challenge:
- every E/D requirement and missing acceptance evidence;
- positive, negative, boundary, bypass and recovery cases;
- exact-change approval binding and alternate deploy paths;
- prompt injection, MCP/plugin overreach, credentials and tenant isolation;
- performance overhead, CI feedback time, failure domains, backup restore and failover;
- ambiguity, contradictions, unsupported claims and stale links.

The primary resolves findings, records justified dissent and repairs the source. Re-run only affected static checks after the single repair update.

### Stage 5 — Static verification only
Allowed:
- Markdown relative-link/path check;
- YAML, JSON and TOML parsing;
- Mermaid source sanity check if a parser is already available;
- requirement-to-control coverage check;
- repository diff, secret-pattern scan and raw-export hash verification.

Not allowed/required:
- no lab, practice, cloud deployment, live provider integration, load-test environment, production test or synthetic service build.

A static parse proves syntax only. A proposed acceptance test remains `PROPOSED / NOT RUN`.

### Stage 6 — Evidence, commit and remote readback
1. Export every actual Codex main and child session in full, raw and unedited form.
2. Preserve native files byte-for-byte under `evidence/raw-sessions/` after completeness/shareability checks.
3. Record one manifest row per actual session, including child sessions if separately exported; compute SHA-256 and verify copied hash.
4. Update the conversation link inventory only with real reviewer-accessible URLs.
5. Update `evidence/VERIFICATION.md` with exact commands/checks and results, including not-run gates.
6. Inspect the full diff, ensure no private candidate state or secrets are committed, make one clear commit and push only to the authorized repository/branch without force-push.
7. Read back the exact commit and files from GitHub. A local commit is not a remote update.

## Definition of done

- E-01..E-06 have explicit evidence and status.
- D-01..D-10 each map to control, enforcement, owner, proposed test and evidence needed to verify the result.
- The proposal explains the engineering/AI operating model, trust boundaries, production approval and developer productivity trade-offs.
- Codex authoring workflow, candidate config and Papaya target-state design are not conflated.
- Specialist reviews were actually spawned or explicitly marked not spawned; findings are integrated.
- Reference configurations are technically sourced, labelled and statically validated; no Papaya deployment is claimed.
- Performance, SLO, reliability, HA/DR, backup/restore, rollback and operations have measurable acceptance methods without invented numeric targets.
- No lab/practice/demo environment was built or required.
- Every actual coding-agent session used is present as a complete raw, unedited, verified native export and reconciled in the manifest.
- GitHub remote readback confirms the final branch/commit and reviewer navigation.
- Candidate-only Logical Questions remain a separate owner-input gate; AI must not invent personal facts or memories.
- Owner approves the final reviewer-facing repository and submission.

## Required Codex closeout response

```text
PAPAYA CODEX SESSION UPDATE
Goal / stage:
Repo / branch:
Starting SHA -> ending SHA:
Codex client/version/model:
Loaded instructions / skill:
Specialist agents actually spawned:
  - agent ID | role | assignment | result
Files added / changed / deleted:
Checks actually run:
  - command | observed result | evidence
Raw session exports:
  - session ID | native path | repo path | SHA-256 | completeness
Git:
  - commit SHA | push status | remote readback
Not run / unknown / blocked:
Next action:
```

Never report a config or conversation as uploaded unless the remote readback confirms it.
