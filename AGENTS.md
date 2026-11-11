# Papaya Take-home — Agent Instructions

## Immutable owner goal

Complete both Papaya take-home parts in this existing repository and prepare exactly one repository URL for the owner to submit to HR. Do not create a replacement repository unless the existing repository is proven unsuitable and the owner explicitly approves replacement.

## Employer acceptance

1. Logical Questions: at least five answers; Q1 and Q5 are mandatory and must be based on the owner's real memories.
2. DevSecOps Challenge 1: complete a source-grounded candidate reference design. Do not claim access to, implementation inside, audit of, or certification by Papaya.
3. Coding-agent requirement from the challenge brief: use a genuine coding agent and preserve every coding-agent session used as a complete, raw, unedited conversation record.
4. HR clarification reported by the owner on 2026-11-11: upload the AI conversations used for the assessment, together with the AI configurations being used. HR also confirmed that the existing repository name is acceptable if the requirements are met. The owner's direct HR message was: “Đưa các coversation với AI lên, bao gồm các configure đang dùng cho AI và kèm thêm conversation còn tên repo thì có thể dùng cái hiện tại, miễn là làm đúng yc là được.”
5. Interpret the HR clarification as covering all assessment-relevant AI conversations actually used to produce the submission, not unrelated personal chats. Keep a manifest that accounts for each relevant conversation and its configuration. Do not claim historical conversations have been captured until their exports are present and verified.
6. One repository must contain both assessment parts and the acceptable conversation/configuration evidence. The repository name itself is not a requirement.

## Source authority

- Challenge 1: https://github.com/papaya-insurtech/pumpkin/blob/main/Hiring/DevSecOps_Challenges/DevSecOps_Challenge_1.md
- Logical Questions: https://github.com/papaya-insurtech/pumpkin/tree/main/Hiring/Logical_Questions
- AI Engineering guidance: https://github.com/papaya-insurtech/pumpkin/blob/main/Hiring/AI_Engineering_Challenges/README.md
- Current submission repository: https://github.com/leminhphap26071995/ai-engineering-devsecops-takehome
- Existing working PR: https://github.com/leminhphap26071995/ai-engineering-devsecops-takehome/pull/1

Re-read authoritative employer sources before changing their interpretation. Preserve exact source revision and distinguish employer facts, owner reports, proposals and unknowns.

## Candidate coding-agent runtime

The owner has selected local Codex as the intended candidate coding-agent runtime for this assessment. Selection is an owner decision, not proof that Codex is installed, configured, invoked or used. Prefer local Codex CLI/Desktop over Codex Cloud for a Free account; current OpenAI guidance says Codex is included on Free while Codex Cloud is not included on Free. Verify the actual local client and version on the owner's machine.

The Papaya target-state design remains Claude Code-aware because that is what the employer scenario specifies. The candidate's intended tool for preparing the assessment is local Codex, subject to the employer's requirements and the capture gate. Do not rewrite the target architecture to claim Papaya uses Codex.

Before substantive Codex work:
- Read this file and the current repository state.
- Verify a harmless local session can be captured in a complete, shareable native/user-visible form.
- Record non-secret configuration in 03-ai-agent-evidence/AI-CONFIGURATION-MANIFEST.md.
- If the native raw file contains provider-internal system/developer instructions or other non-shareable material, do not publish it or silently redact it. Stop and obtain an employer-acceptable export approach.

## Scope and owner boundaries

- Do not invent Q1/Q5 autobiographical facts. Ask the owner for the facts and use their wording.
- Do not fabricate hands-on experience, compliance ownership, production deployment, tests, security audit, or Papaya environment access.
- No real customer/claim/medical/identity/banking data, credentials, tokens, cookies, private keys or secrets in prompts, logs or repository.
- Do not send email, publish a final submission, merge the PR or change repository visibility without explicit owner approval.
- The owner retains final review, personal-fact confirmation and submission authorization.

## Efficient execution and repository hygiene

- Continue in the existing repository and current PR branch unless live source state proves otherwise.
- Prefer one coherent documentation batch and one meaningful commit for the remaining preparation. No micro-commits, commit-per-file or commit-per-test.
- Do not create throwaway test files, duplicate deliverables, generic CI workflows or unrelated infrastructure.
- For documentation-only changes, do not run broad code/test suites. Run only a small requirement-derived Markdown/link check if it materially verifies the changed content; otherwise record that no tests were applicable.
- Do not create test artifacts merely to demonstrate activity. Do not discard/recreate the repository because of a small, coherent history.
- Keep raw AI transcripts byte-for-byte unchanged. Store metadata and hashes in separate manifests.
- Every assessment-relevant AI conversation actually used must be inventoried. Capture subagent/fork sessions separately when they are real sessions.
- If a capture is incomplete, ambiguous, unsafe to publish or contains secrets, mark it BLOCKED; never fabricate or edit a transcript to force PASS.

## Definition of done

Every employer MUST above maps to a repository artifact and direct evidence. The repository is not ready until the content, all required AI conversations/configurations, privacy/security review, links/access and owner acceptance are verified. A draft PR or a successful local check is not final submission.


## Codex UPW plugin and provider-neutral project routing

This repository pins the reusable Unified Project Workflow (UPW) Codex plugin from the canonical architecture repository:
- Plugin: \`unified-project-workflow\`, version \`0.1.98\`
- Source: \`leminhphap-improvement/ai-workflow-archtiecture\`
- Source revision: \`7b19d78bd3db8091d5ab5aa827031c60065e49bc\`
- Repo-local marketplace: \`.agents/plugins/marketplace.json\`
- Installation guide: \`docs/WORKFLOW-PORTABILITY.md\` and \`03-ai-agent-evidence/CODEX-CAPTURE.md\`

Use the Codex-native UPW plugin/skills for goal anchoring, context recovery, professional capability routing, project/ticket isolation, source-first engineering, gates 5–6–7, failure recovery, CI lifecycle and evidence-backed closure. The project also vendors the selected complete four-artifact role packs under `.agents/skills/` and Codex custom-agent adapters under `.codex/agents/`. Verify actual plugin installation and skill invocation; repository metadata alone is not proof of activation.

### Provider neutrality is mandatory

- The reusable workflow core must not assume Notion + GitHub or any other fixed ticket/knowledge/source-control stack.
- Resolve project registry, work management, knowledge base, source control, CI/CD and evidence storage independently through the project's authority map and actual host adapters.
- Jira may own tickets while Confluence owns long-form knowledge; GitHub/GitLab/Bitbucket may separately own source. These are future-compatible examples, not claims that those integrations are currently connected.
- For this assessment repository, GitHub is the actual source-control host because the existing submission repository is hosted there. The owner's Notion campaign/ticket records are personal work-management context; the submitted repository must remain understandable and usable without access to that Notion workspace.
- Do not require Notion connectors, GitHub Issues, or any ticket ID to build, inspect or use the repository. Do not treat a ticket key, knowledge page, PR/MR or pipeline run as interchangeable identifiers.
- No Jira/Confluence adapter is implemented or verified by this submission. Do not claim it is. A future project can change the authority map and connect/test those adapters without rewriting UPW core.
- The Papaya target architecture remains grounded in the employer's stated stack. Candidate-side Codex workflow tooling must not be confused with Papaya's target coding-agent environment.


## Role routing and concise communication

Follow [ROLE-ROUTING-AND-COMMUNICATION.md](00-ai-engineering-workflow/ROLE-ROUTING-AND-COMMUNICATION.md). Do not load or enumerate every role. Use one accountable primary role and load only the specialist bundle needed for the current work phase. A role is a method bundle, not an independently running agent.

For ordinary interaction, answer directly in the user's language: state root cause when applicable, then solution, then only one relevant trade-off, prevention or future improvement. Trade-off means a material cost or limitation of the chosen option; prevention means a control for recurrence/security/reliability risk; improvement means a concrete future optimization. Omit irrelevant categories. Use natural prose, no unnecessary headings/labels, no inflated or agentic wording, up to five sentences and a 20–30 whitespace-unit target. Never truncate a required fact to meet the limit. Keep technical terms precise and explain unfamiliar ones simply. Full technical artifacts are exempt from the short-answer limit.

Use [CONTEXT-COMPILER-DESIGN.md](00-ai-engineering-workflow/CONTEXT-COMPILER-DESIGN.md) as the current language-bridge contract. The project-local script at scripts/language_bridge.py now implements raw-request normalization, a structured context envelope, an agent outbox and reverse translation. It does not parse arbitrary repository documents or fetch sources; the agent must still inspect authoritative files. Seven unit tests pass with a mocked Codex helper, but live Codex execution, local authentication, helper-session capture and host activation remain NOT_VERIFIED. Do not use the bridge for assessment work until the harmless capture probe proves that every prepare/finalize helper session has a complete, shareable native transcript; otherwise keep the main agent in the source language.


## Codex project configuration and specialist roles

- Project-scoped Codex defaults and UPW plugin enablement: `.codex/config.toml`.
- Custom read-only supporting agents: `.codex/agents/`.
- Complete project-discoverable role skills: `.agents/skills/`; exact canonical source commit and artifact Git blob SHAs: `.agents/skills/role-pack-provenance.json`.
- Task-specific assessment workflow: invoke `$papaya-takehome` only after the harmless Codex transcript-capture gate passes.
- UPW marketplace: `.agents/plugins/marketplace.json`; plugin `unified-project-workflow` v0.1.98 pinned to `ai-workflow-archtiecture@7b19d78bd3db8091d5ab5aa827031c60065e49bc`.

The main Codex thread is the accountable `software-architect` primary. Invoke its project skill `$software-architect` and load its sibling `mindset.md`, `knowledge.md` and `workflow.md`. Spawn the read-only `security_reviewer`, `devops_engineer` and `qa_engineer` custom agents only when their phase is active. `ai_native_tooling_engineer` is conditional for Codex/plugin installation and configuration work. Every spawned session is a separate assessment-relevant conversation and must be inventoried and captured if used.

The project config deliberately does not pin a model, reasoning effort, account, global provider, MCP server or credentials. Record the actual client/version/model/reasoning and host-level settings from the local Codex session. The project defaults request approval on demand and workspace-write for the parent; specialist agents are read-only. These are configuration defaults, not a security boundary or proof that the local host loaded them. Codex only loads project-scoped config after the owner trusts the repository; CLI flags and managed requirements may further affect effective behavior.

For Challenge 1, use only the four engineering roles in the documented phase order. Logical Questions require no engineering role; Q1/Q5 remain owner-fact-only. Do not use the language bridge for assessment content until every helper session has a complete, shareable transcript.
