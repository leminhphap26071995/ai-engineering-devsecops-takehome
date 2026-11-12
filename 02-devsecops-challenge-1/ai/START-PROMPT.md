# Start prompt — Codex

## Session 1: verify native capture only

Open the **repository root** in Codex. Do not start substantive assessment work yet.

Run only the harmless read-only probe from `02-devsecops-challenge-1/evidence/CODING-AGENT-CAPTURE.md`. Verify the actual Codex client/version/model, workspace root, branch/HEAD, loaded instruction files, available skill and custom agents. Do not infer runtime discovery from file presence.

End the probe session, export its complete native conversation using the actual client's supported mechanism, inspect completeness/shareability without editing the original, calculate SHA-256 and record it in `02-devsecops-challenge-1/evidence/SESSION-CAPTURE-RECORD.md`. If this cannot be done, stop and report the exact blocker.

## Session 2: execute the assessment

Start a new Codex session at the repository root and submit:

```text
Invoke $papaya-takehome. Read 02-devsecops-challenge-1/ai/CODEX-EXECUTION-PLAN.md and execute its full scope, not merely a plan or status report.

You are the accountable DevSecOps Engineer in the main thread. Keep Project Manager and Technical Lead coordination in this thread. Load the complete DevSecOps four-artifact role pack. Spawn the named read-only specialist agents in the exact waves and scopes defined by the execution plan; wait for their real results, integrate findings, then implement the coherent documentation/reference-configuration scope. Spawn QA after integration and repair material findings.

Do not build a lab, practice environment, synthetic cloud, demo service or deployment. Do not access Papaya systems or real customer data. Do not claim proposed tests were executed. Do not use Claude as the candidate-side authoring host; preserve Claude Code only as Papaya's stated scenario context.

Preserve every actual main/child Codex session as a complete raw native export. Update the evidence manifest, verification record and repository configuration/docs only from actual results. Run the allowed static checks, commit and push the verified changes to the authorized GitHub repository, then read back the exact remote SHA and files.

Continue through all AI-owned work. Finish with the exact PAPAYA CODEX SESSION UPDATE format in CODEX-EXECUTION-PLAN.md. Mark every unverified or owner-only gate explicitly.
```
