# AI Engineering + DevSecOps Take-home

This repository contains the two Papaya assessment workstreams and supporting AI conversation/configuration evidence:

1. **Logical Questions** — at least five truthful answers, including mandatory Q1 and Q5.
2. **DevSecOps Challenge 1** — a source-aligned design for secure Claude Code use across Papaya's engineering and production delivery lifecycle.
3. **AI conversation and configuration evidence** — every assessment-relevant AI conversation actually used, with complete acceptable exports and non-secret configuration records.

## HR clarification — 2026-11-11

The owner reports that HR confirmed:
- Upload the AI conversations used for the assessment, including the AI configurations being used.
- The existing repository name may be retained if the requirements are satisfied.

The challenge brief's stricter coding-agent requirement remains: every coding-agent session used must have a complete, raw, unedited conversation record. Do not assume a summary or reconstructed transcript is acceptable.

## Current design direction

The Challenge 1 proposal is anchored in the employer's stated platform: Claude Code Team Premium, internal plugin marketplace, GitHub monorepo, GitHub Actions, Pulumi, Serverless Framework, AWS primary, GCP Vertex/Gemini, k0s and Firebase Hosting.

It distinguishes developer coding agents from production AI agents and preserves Pulumi/Serverless ownership. Terraform is conditional, not assumed or required for multi-cloud.

The candidate now has Codex access through a ChatGPT Free account (owner-reported). Codex is an available local coding-agent option, not yet proof of actual use or successful transcript capture. The target architecture remains Claude Code-aware.

> Working draft. A genuine coding-agent session, acceptable raw conversation capture, configuration evidence, technical verification, owner review and final submission are still required.

| Gate | State |
|---|---|
| Repository | Existing repository verified public; HR permits reuse if requirements are met |
| Employer source review | Challenge 1 and Appendix A read from GitHub main |
| Challenge design | Reworked against source facts; coding-agent critique pending |
| Multi-cloud IaC | Pulumi + Serverless default; Terraform conditional |
| Assessment-relevant AI conversations | Inventory and acceptable exports pending |
| Codex local raw capture | Pending harmless probe and shareability review |
| AI configuration evidence | Non-secret manifest prepared; actual values pending |
| Logical Questions | At least five answers pending; Q1/Q5 require owner facts |
| Secret/PII/provider-internal-instruction review | Pending |
| Owner approval / HR submission | Pending |

## Navigation
- [AI Engineering Workflow](00-ai-engineering-workflow/README.md)
- [DevSecOps Challenge 1](02-devsecops-challenge-1/README.md)
- [Logical Questions](01-logical-questions/README.md)
- [AI Conversation and Coding-Agent Evidence](03-ai-agent-evidence/README.md)
- [Verification](04-verification/README.md)

## Evidence boundaries
- The Papaya design is a candidate proposal, not implementation, audit or certification of Papaya.
- Employer-stated facts, owner-reported HR clarifications, design recommendations and unknowns are explicitly separated.
- AI conversation exports must be complete, genuine and unedited where required by the challenge.
- Non-secret AI configuration must be recorded; credentials and provider-internal instructions must not be published.
- No real claims/member data, credentials, tokens or secrets should be included in source or raw transcripts.
- Personal-memory answers must come from the owner.

## Primary sources
- [Papaya DevSecOps Challenge 1](https://github.com/papaya-insurtech/pumpkin/blob/main/Hiring/DevSecOps_Challenges/DevSecOps_Challenge_1.md)
- [Papaya Logical Questions](https://github.com/papaya-insurtech/pumpkin/tree/main/Hiring/Logical_Questions)
- [Codex plan availability](https://help.openai.com/en/articles/11369540-using-codex-with-your-chatgpt-plan)


## Portable Codex workflow

The repository includes a repo-local Codex marketplace at \`.agents/plugins/marketplace.json\`, which pins UPW v0.1.98 from the canonical AI Workflow Architecture repository at commit \`7b19d78bd3db8091d5ab5aa827031c60065e49bc\`. See [Workflow Portability](docs/WORKFLOW-PORTABILITY.md) and [Codex capture guide](03-ai-agent-evidence/CODEX-CAPTURE.md).

UPW core separates project routing, work management, knowledge base, source control, CI/CD and evidence storage. It does not require Notion + GitHub. Jira + Confluence or other combinations can be configured later through verified adapters. This submission currently uses GitHub as its source-control host; the owner's Notion campaign is not a runtime or submission dependency. Jira/Confluence integrations are not included or verified here.



## Two-way language bridge

A project-local Python reference implementation is available at scripts/language_bridge.py. It normalizes raw requests into a structured context, lets the main agent write an answer to an outbox, then translates and compresses the answer into the user's language. Seven unit tests pass with a mocked Codex helper; live Codex execution is not verified.

The bridge uses separate Codex helper sessions. Do not use it for assessment work until each helper's native transcript can be captured and safely shared; its event JSONL is not a transcript replacement.
