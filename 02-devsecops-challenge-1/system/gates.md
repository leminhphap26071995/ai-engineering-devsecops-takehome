# Quality and approval gates

| Gate | Owner | Required work | Exit evidence |
|---|---|---|---|
| G0 — Workspace and capture | Candidate + selected host | Verify employer source/repository revision; trust the repository; run the harmless native capture probe before substantive coding-agent work | Exact source lock; complete and shareable export proven for the selected client/export path |
| G1 — Requirement baseline | Project Manager | Break requirements into MUST/SHOULD/LATER/UNKNOWN and define how each MUST will be checked | Versioned goal contract; no unresolved material MUST |
| G2 — Design challenge | Technical Lead + DevSecOps | Assets, trust boundaries, threat paths, architecture, ownership, assumptions and ADRs | Requirement-to-component map; conflicts recorded |
| G3 — Specialist review | Relevant specialists | Bounded independent reviews with counterexamples and source evidence | Findings classified and resolved; material dissent preserved |
| G4 — Delivery and assurance | DevOps + Security Assurance | CI/cloud/IaC feasibility, framework mapping, privacy and operational ownership | A map from each control to its enforcement point, test, evidence and owner |
| G5 — Acceptance | QA + primary | MUST coverage, positive/negative/boundary/bypass cases, links, diagrams and evidence provenance | Every requirement checked against evidence; unverified claims labelled as proposed or unknown |
| G6 — Candidate release | Candidate | Candidate-specific claims, consent, privacy review, repository access and submission authorization | Explicit approval; submission result confirmed |

## Stop and return rules

- Ambiguous MUST returns to PM; do not guess.
- Architecture conflict returns to Technical Lead; a specialist cannot silently overrule another domain.
- A control without enforcement or test remains OPEN/UNKNOWN.
- Missing/unsafe capture blocks substantive coding-agent work, not independent source research.
- Proposed test is not a result; static file check is not host runtime discovery; committed config is not proof of effective settings.
- Failed gates do not stop independent safe work.
- Papaya production access and real customer data are outside the assessment scope.
