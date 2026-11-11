# Context Compiler and Two-Way Language Bridge

**Status:** Project-local reference implementation is present. Seven unit tests pass with a mocked Codex helper. Live Codex execution, authentication, model selection and native transcript capture are NOT VERIFIED.

## Goal

Let the human write in any language while the main agent works in a measured, configurable language, then return a concise answer in the human's language without losing requirements or evidence.

## Actual implementation

The project-local script is scripts/language_bridge.py.

1. prepare reads one raw request from a file or stdin, stores it unchanged under the private state directory and records SHA-256.
2. A read-only Codex helper normalizes the request into a structured envelope: source/agent/response language, goal, intent, scope, non-goals, atomic acceptance with priority/source, constraints, decisions, evidence/status/source, unknowns, source references, next action and critical tokens.
3. The main agent reads the returned context path, retrieves original project/employer sources where needed, performs the work and writes a structured answer to the returned outbox path.
4. finalize reads that answer and invokes a read-only Codex helper to translate and compress it into the response language.
5. Python validates required fields, exact critical tokens, output language, negation-preservation acknowledgement, uncertainty-preservation acknowledgement, sentence count and approximate length. It retries compression at most three times and never truncates.

The main agent does not need to write final user-facing prose directly. It writes the answer plus evidence/uncertainties to the outbox and runs finalize.

## Responsibility boundaries

| Layer | Owns | Does not own |
|---|---|---|
| Python bridge | Private file handling, stable task ID, hashes, JSON schema, exact-token checks, output routing, bounded retries | Semantic translation, intent inference or deciding which requirements matter |
| Codex helper model | Language detection, semantic normalization, translation and concise rewriting | Changing owner intent, resolving conflicts silently or inventing evidence |
| Main agent | Original-source inspection, reasoning, implementation and evidence-backed answer content | Treating the compact envelope as stronger than source |
| Original sources | Authoritative requirements and evidence | Being replaced by a compressed summary |

## Language selection

- UPW_AGENT_LANGUAGE=auto uses a profile only when it is marked VERIFIED for the exact UPW_MODEL_ID.
- Without a verified profile, auto keeps the source language. English is not assumed to be optimal.
- Benchmark candidate languages against the same representative tasks and acceptance tests. Compare task success, requirement retention, negation/identifier fidelity, input/output tokens, latency and translation quality.
- UPW_TRANSLATOR_MODEL can select a helper model, but lower usage/cost is not guaranteed.

## Human-facing answer contract

For ordinary answers, state root cause when one exists, then the solution. Add only one relevant final concern:
- Trade-off: material cost or limitation of the chosen option.
- Prevention: control required to reduce recurrence, security or reliability risk.
- Improvement: concrete future optimization that remains.

Do not force all three. Use natural prose, no unnecessary headings or labels, no AI-agentic filler, at most five sentences and a target of 20–30 whitespace-separated units. The count is approximate, not a language tokenizer. Preserve meaning over length; return OVER_LIMIT_PRESERVED rather than truncating. Full technical artifacts remain complete.

## Limits and safety

- The current script accepts raw request text only. It does not parse arbitrary repository files, fetch URLs or independently retrieve evidence. The main agent must inspect original sources and preserve source references in the task.
- The bridge stores raw input, context, outbox, final output and helper traces under ~/.upw/language-bridge by default, outside the repository. Override the state directory only with a private, Git-excluded path.
- Each prepare/finalize call starts a separate Codex exec session with read-only sandboxing and an isolated working directory. These calls consume model usage.
- The script's JSON event trace is diagnostic evidence, not the native raw conversation export. Every helper session used for the assessment must be inventoried and its native rollout independently captured and reviewed for shareability.
- Do not use the bridge for assessment work until the harmless capture probe confirms that every helper session can be captured completely and safely. If not, use the main agent directly in the user's language.
- Exact-token checks are deterministic, but meaning_preserved/uncertainties_preserved/negation_preserved are model assertions, not mathematical proof. High-impact output still needs source review.

## Verification

Seven unit tests pass in the local isolated runner. They mock the Codex subprocess and cover profile selection, raw/context persistence, critical-token handling, read-only command construction, multilingual negation and no-truncation behavior. No live Codex helper session has been run from the owner's machine.
