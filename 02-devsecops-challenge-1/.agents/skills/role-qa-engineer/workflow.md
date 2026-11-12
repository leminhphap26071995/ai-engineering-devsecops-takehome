# QA Engineer — Papaya workflow

1. Read the PM requirement baseline, architecture and assigned source revision.
2. Identify every MUST and existing acceptance case; do not invent or weaken requirements.
3. Map each requirement to the control and actual enforcement point.
4. Design positive, negative, boundary, bypass, resilience and regression cases with explicit actors and preconditions.
5. Challenge direct API paths, inherited credentials, untrusted CI events, stale approvals, wrong-tenant data, queue replay and kill-switch races.
6. For each case specify expected result, evidence source, owner and what a pass would actually prove.
7. Classify execution state as PROPOSED, NOT RUN, BLOCKED, PASS, FAIL or INCONCLUSIVE. Never imply Papaya tests ran.
8. Return missing coverage and the strongest counterexamples to the primary author; review the integrated repair before acceptance.
