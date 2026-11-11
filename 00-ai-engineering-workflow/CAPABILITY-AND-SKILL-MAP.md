# Capability and Skill Map

This map describes capability families, not a roster of independently running agents.

| Capability | Responsibility | Methods / skills | Evidence boundary |
|---|---|---|---|
| Workflow governance | Intent routing, project isolation, continuity | always-on-guard, ai-manager, context-recovery | Workflow contract and source readback |
| Requirements engineering | Scope, acceptance and traceability | engineering-full-flow, chat-mode-closed-loop | Requirement-to-test/evidence map |
| Professional discovery | Identify missing domain disciplines | professional-capability-discovery, professional-roles | Deliverable coverage and loaded specialist method |
| Interview domain | Truthful candidate claims and preparation | career-learning / career-training | JD/CV source, owner facts, campaign checkpoint |
| AI tooling lifecycle | Discover/configure tools and plugins | ai-tooling-lifecycle | Discovered/installed/configured/connected/invoked/verified states |
| Cloud/DevOps | CI/CD, IaC, runtime and operations | DevOps/SRE/cloud specialist methods | Source, pipeline, runtime and operations evidence |
| Security/privacy | Threat model, identity, permissions, data boundaries | Security, cloud-security, privacy/compliance methods | Threat scenarios, policy tests, audit evidence |
| Coding execution | Multi-file source changes and commands | Codex local (intended; host/capture verification pending); optional subagents | Native session transcript, diff and commit |
| Verification | Test design, adversarial checks, exact-SHA CI | QA/security review and skeptical verification | Executed output, CI logs and findings |

## Terms

- **Skill:** reusable instructions, knowledge and workflow method.
- **Role profile:** defines a professional perspective and deliverables.
- **Subagent:** separately invoked execution context with its own task/context and observable result.
- **Coding agent:** runtime that can inspect/modify source and run commands.
- **Model router:** selects model/provider inference; it does not grant source or infrastructure permissions.

Only call something a subagent when a real child execution is observed and its evidence can be retained.
