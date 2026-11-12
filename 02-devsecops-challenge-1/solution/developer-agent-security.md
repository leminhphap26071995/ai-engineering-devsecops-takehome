# Developer coding-agent security

## Policy objective
Allow engineers to use Claude Code productively while ensuring the agent cannot inherit broad workstation authority or bypass independently enforced security controls.

## Identity and execution
- Treat each coding-agent session as an untrusted process with a bounded task.
- Use a managed dev container, VM or equivalent isolated workspace for tasks needing shell execution or external tools.
- Do not mount/expose ~/.aws, AWS SSO cache, production profiles, cloud credential files, SSH private keys, browser profiles, Docker socket or unrelated host directories.
- Start from a clean environment: deny host mounts, Unix/Windows sockets, Docker sockets, SSH-agent forwarding, localhost/link-local and cloud-metadata access; restrict child processes and default-deny egress with an explicit non-production allowlist. Record denials outside the model.
- Do not place production secrets or real insurance member/claim data in the agent workspace.
- Prefer short-lived task credentials scoped to one repository, environment and operation.
- End sessions by revoking temporary grants and destroying/re-imaging ephemeral workspaces for high-risk tasks.

## Claude Code controls

This section describes target-state controls for Papaya's stated Claude Code environment. It does not mean this candidate repository ships a Claude Code adapter; candidate-side Codex configuration is documented in [AI configuration](../AI-CONFIGURATION.md).

Claude Code supports organization-managed, project-shared and developer-local configuration scopes. They are not equivalent:
- Organization-managed settings are the enforcement layer where available; verify the active source with Claude Code's status/configuration view.
- A committed .claude/settings.json is useful for team defaults, shared hooks and project policy, but is not a substitute for organization-managed controls.
- Developer-local settings can override shared project settings in relevant precedence cases. Do not rely on a repository file alone to prevent a determined user changing local behavior.
- Define an approved permission mode and deny rules for protected paths, credential stores and destructive operations.
- Where supported by managed policy, disable bypass-permissions mode. If central enforcement is unavailable on the actual plan, enforce the same boundary with endpoint management and OS/runtime isolation.
- Use Claude Code sandboxing for filesystem/network boundaries where supported by host OS. Sandbox complements, but does not replace, cloud IAM or host isolation.
- Hooks can provide deterministic validation, telemetry and workflow checks. Hooks are not the only authorization boundary.

## Internal plugin marketplace and MCP governance
Treat the internal plugin marketplace as part of the software supply chain. Before publishing a plugin or MCP server, record:

| Field | Required review |
|---|---|
| Owner and business purpose | Named team, supported workflow and support contact |
| Source and provenance | Repository, publisher, release source and build provenance |
| Version and integrity | Immutable version/digest, dependency lock and change history |
| Permissions | Tools exposed, filesystem/network access, side effects and credential scopes |
| Data handling | Data classes read/written, retention, external destinations and provider terms |
| Security testing | Static/dependency scan, malicious-input tests and install-script review |
| Runtime policy | Allowed users/groups, environments, model/provider and required approvals |
| Operations | Monitoring, version retirement, emergency disable and credential revocation |

Controls for the **Claude Code CLI plugin marketplace**:
- Use managed-settings strictKnownMarketplaces to allowlist the exact internal marketplace source(s). The managed restriction is checked before network/filesystem operations and on marketplace add, plugin install, update, refresh and auto-update; user/project settings cannot override it.
- Use extraKnownMarketplaces to pre-register the approved marketplace for users and managed dev environments. Pair strictKnownMarketplaces with disableSideloadFlags to reject CLI flags that sideload plugins, agents or MCP servers.
- Inventory already-registered marketplaces. If a source no longer matches the managed allowlist, Claude Code refuses new installs/updates from it; remove unapproved entries and verify the effective policy.
- Prefer a private/internal Git marketplace with reviewable marketplace.json and plugin source. Pin git plugin sources to an exact commit SHA where appropriate; bump plugin.json version on every release if explicit versions are used. Pin archive packages by SHA-256.
- Restrict user-added marketplaces, one-off plugins, user-created skills and unreviewed MCP servers according to organizational policy.
- Give each plugin only the tools and credentials needed for its documented task.
- Runtime admission must verify the approved publisher/source, immutable version or digest, locked dependencies/SBOM and permission manifest before loading. Disable alternate MCP/configuration/sideload paths where the managed host supports that control, and revoke active sessions when the digest or policy is withdrawn.
- Treat tool output as untrusted input and validate arguments/results outside the model.
- Provide a fast emergency block/revoke process.

The marketplace is not the only boundary: a reviewed plugin can still be compromised or over-privileged. The runtime therefore fails closed on digest drift, dependency drift, unregistered direct MCP URLs and update attempts during an active session. Evidence includes the admission decision, owner/version/digest, dependency lock, permission manifest and revocation record.

**Product distinction:** Claude Code CLI plugin marketplaces (marketplace.json, /plugin commands, strictKnownMarketplaces) are not the same product surface as the separate Claude.ai/Claude Desktop organization plugin catalog for Cowork. The challenge says "internal Claude Code plugins"; use the CLI marketplace controls as the baseline and confirm Papaya's actual distribution path before relying on other admin features.

## Plan and product capability caveats
- The scenario names Claude Code Team Premium, but the design must verify which administrative controls are actually available on Papaya's contract and tenant configuration.
- Claude Code CLI plugin marketplaces use the native marketplace.json and /plugin workflow. Centrally restricting sources uses managed-settings strictKnownMarketplaces; this is distinct from the separate Claude.ai/Claude Desktop plugin catalog for Cowork.
- Enterprise-only features such as Inference Hooks are optional enhancements, not assumed baseline controls.
- Do not assume Team Premium or ordinary Claude Code use provides HIPAA BAA coverage for PHI. Anthropic states that Team plans cannot enable its HIPAA configuration. Even on Enterprise, Claude Code is covered by the BAA only for qualified accounts with HIPAA readiness and zero data retention (ZDR) enabled; enabling HIPAA readiness alone is insufficient. Each feature must be checked against the official HIPAA implementation guide because not every Enterprise feature is covered, and Cowork is currently not covered. Default policy: no PHI or real claim/member records in coding-agent sessions; use synthetic/sanitized data unless legal/privacy owners verify the exact covered service, account and feature.

## Capability matrix

| Capability | Default | Conditions |
|---|---|---|
| Read assigned repository | Allow | Approved repo and task scope |
| Edit source/tests in assigned workspace | Allow | Isolated workspace; branch only |
| Run approved local tests/lint/build | Allow | Sandboxed process and bounded resources |
| Read arbitrary host files/credential stores | Deny | Explicit temporary exception only; never production credentials |
| Internet egress | Deny by default / allowlist | Approved model, package and tool destinations |
| MCP/plugin installation | Deny direct install | Marketplace-reviewed release only |
| Read production secrets or raw claims | Deny | Not required for coding-agent work |
| Read sanitized operational telemetry | Conditional | Scoped, read-only, audited and purpose-limited |
| Author Pulumi/Serverless/IaC changes | Allow | Static checks/preview only; no apply credentials |
| Change IAM/org policy/branch protection/audit settings | Deny | Dedicated reviewed administrative workflow |
| Approve own PR or production change | Deny | Human reviewer/approver only |
| Deploy to production | Deny | Protected CI/CD path with named human approval |

The separation is bidirectional. Coding-agent identities deny production-AI endpoints, tenant data and production credentials; production-AI workload identities deny GitHub write/admin, CI workflow administration, developer workspaces, plugin-registry administration and deployment-role assumption. Enforce this with separate identities, network policy and resource/application authorization, then test both denied directions.

## Keep the workflow fast without weakening security
Do not solve prompt fatigue by disabling all permission prompts. Pre-approve low-risk deterministic commands inside an isolated workspace; keep risky file, network, credential and deployment operations denied or explicitly reviewed. This preserves fast local iteration while moving security from repeated UI clicks to enforceable boundaries.

## References
- [Claude Code settings and precedence](https://code.claude.com/docs/en/settings)
- [Claude Code sandboxing](https://www.anthropic.com/research/claude-code-sandboxing)
- [Claude Code CLI plugin marketplaces and managed restrictions](https://code.claude.com/docs/en/plugin-marketplaces)
- [Inference Hooks overview — Enterprise availability](https://support.claude.com/en/articles/16059458-inference-hooks-overview)
- [Claude Code local mode on HIPAA-ready Enterprise](https://support.claude.com/en/articles/17318731-use-claude-code-local-mode-and-claude-cowork-local-mode-on-a-hipaa-ready-enterprise-plan)
