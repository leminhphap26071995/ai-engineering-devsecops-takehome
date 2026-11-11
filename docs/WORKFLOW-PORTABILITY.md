# Workflow Portability and Provider Boundaries

## Why this exists

The reusable UPW workflow is being brought into Codex for the assessment, but the ticket/knowledge stack may change later. The workflow must not make a public submission depend on the owner's current Notion + GitHub setup.

## Current project facts

- The submission repository is hosted on GitHub; GitHub is the current source-control host for this project.
- The owner currently tracks the Papaya campaign and ticket context in a private Notion workspace. That is owner-side project management context, not a runtime dependency of this public repository.
- The Papaya target architecture remains grounded in the employer's published brief and must not be rewritten to match candidate-side Codex tooling.
- The canonical UPW plugin is pinned from \`leminhphap-improvement/ai-workflow-archtiecture\` at commit \`fd981a03839566875146e9c853b52861db63396d\`, version \`0.1.97\`.

## Provider boundaries

| Concern | Current Papaya assessment | Future-compatible alternative |
|---|---|---|
| Project/ticket management | Owner-side Notion record; not required by submission repo | Jira, Linear, Azure Boards, GitHub Issues or another configured tracker |
| Knowledge base | Repository Markdown plus owner-side Notion context | Confluence, Notion, SharePoint or docs repository |
| Source control | GitHub repository and PR | GitHub, GitLab, Bitbucket or Azure Repos |
| CI/CD | No required CI workflow for the current documentation-only package | GitHub Actions, GitLab CI, Jenkins, Azure Pipelines, Buildkite |
| Evidence | Repository artifacts/manifests and approved raw session exports | Approved repository, object store or provider attachments |

The current table describes this project only. It is not a default stack for UPW.

## Runtime behavior

- Codex loads project \`AGENTS.md\` and the installed UPW plugin skills.
- UPW core resolves authorities by concern through the project map and actual host connectors.
- No Notion, Jira, Confluence, GitHub Issues or GitLab API is assumed to exist merely because the provider is named in a document.
- A missing adapter remains UNKNOWN/BLOCKED. The workflow does not silently replace a ticket with a README or a knowledge page with a source-control issue.
- The plugin contains no MCP server definitions, credentials, OAuth scopes or provider-specific secrets.

## Moving to Jira + Confluence later

1. Add a project authority map that identifies Jira as work-management authority and Confluence as knowledge-base authority.
2. Connect the approved Jira and Confluence adapters in the actual Codex host.
3. Verify authenticated identity, least-privilege scopes, project/space identifiers, search/read behavior, write permissions and readback.
4. Map stable project/ticket/goal/requirement IDs and explicit links to source-control PRs/commits.
5. Reconcile/migrate current ticket and knowledge records, confirm the new authority with the owner, then retire Notion as an authority for that project.
6. Keep source control and CI/CD independent; GitHub may remain, or be replaced separately.
7. Do not claim the migration is complete until provider-level and consumer-level evidence passes.

## Non-goals

- This submission does not implement Jira or Confluence connectors.
- This submission does not migrate the owner's private Notion data.
- This submission does not claim all Codex clients/Free accounts expose identical plugin or connector capabilities.
- This document does not alter Papaya's employer-defined target stack.
