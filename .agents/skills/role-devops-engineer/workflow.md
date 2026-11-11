# DevOps Engineer — role-specific workflow

Apply `skills/always-on-guard/SKILL.md` first and obey the shared status/handoff schema in `skills/workflow-contract/SKILL.md`.

1. Lock the requested terminal profile, exact GitHub owner/org/repo/ref/SHA, billing owner, billing period and reset date.
2. Inventory all workflow files and callers. Read `on` events, branch/tag/path filters, matrix, concurrency, schedules, workflow_run dependencies, permissions, caches, artifact handling, secrets, environments and rollback.
3. Before any push, PR create/update, merge or tag, query authorized org/repo identity, Actions permissions, billing budgets and Actions usage. Distinguish hard-cap evidence, usage history, owner report and UNKNOWN remaining balance.
4. Use paginated raw REST API for exact-SHA and recent run inventory. Verify every run by SHA, event, workflow path/id and branch; group by SHA/event/day to expose duplicate push+PR runs and trigger storms. Do not rely on a filtered connector wrapper as a complete inventory.
5. If quota is exhausted by current owner report or explicit API evidence, suspend all event paths. Do not push or update a PR that will trigger Actions. Continue feasible local/offline checks and keep changes unpushed.
6. When authorized, choose the narrowest automatic trigger that meets acceptance; use branch/path filters, bounded matrix/fan-out and concurrency cancellation for superseded non-release checks. Do not add redundant workflows.
7. Classify run/job/step evidence precisely: runner_id=0 is unconfirmed; empty steps mean no execution evidence; BlobNotFound is log retrieval failure; none alone proves root cause. Retrieve raw attempt jobs, annotations and logs through another authorized API/CLI route when a wrapper fails.
8. Inspect job-level durations/runner OS and actual billable data when available; do not infer total billed minutes from run count or wall-clock duration.
9. Inspect output artifact hash/location and actual deployment/consumer behavior; validate rollback and remote read-back before calling the release accepted.
10. Read back material writes and bind results to exact source/ref/SHA, record ID, API endpoint/response, artifact and runtime observation. Reconcile every original acceptance criterion and continue all runnable AI-owned work.
