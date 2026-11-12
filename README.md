# Papaya Take-home — AI-assisted DevSecOps engineering

This repository contains the two Papaya assessment deliverables. The technical assessment is a **reference design for integrating coding agents into real DevSecOps engineering**, not a vendor-specific setup guide or a claim that Papaya's systems were accessed or changed.

## Start here

1. Read the employer requirements in each assessment folder.
2. For the technical challenge, start with [the integrated proposal](02-devsecops-challenge-1/solution/PROPOSAL.md).
3. Use the [AI-assisted engineering workflow](02-devsecops-challenge-1/solution/ai-assisted-devsecops-workflow.md) to understand how a coding agent should reason and contribute across the delivery lifecycle.
4. Use the [DevSecOps role pack](02-devsecops-challenge-1/.agents/skills/devsecops-engineer/) as the accountable engineering method. Load supporting specialists only when their expertise is needed.
5. Use an available coding-agent host and its supported project instructions/configuration. The workflow is host-neutral; the checked-in `.codex/` directory is one available adapter, not the security boundary.
6. Preserve every actual coding-agent session as a complete, raw, unedited export when the employer requires it. See [session evidence](02-devsecops-challenge-1/evidence/).

## Technical assessment map

| Concern | Canonical source |
|---|---|
| Employer requirements and scope | [Requirements and acceptance](02-devsecops-challenge-1/solution/requirements-and-acceptance.md) |
| Integrated reference design | [Proposal](02-devsecops-challenge-1/solution/PROPOSAL.md) |
| AI task reasoning and lifecycle | [AI-assisted DevSecOps workflow](02-devsecops-challenge-1/solution/ai-assisted-devsecops-workflow.md) |
| System/role boundaries | [Operating model](02-devsecops-challenge-1/system/operating-model.md), [role catalogue](02-devsecops-challenge-1/system/role-catalog.md) |
| Secure CI/CD and production change | [Secure delivery workflow](02-devsecops-challenge-1/solution/secure-delivery-workflow.md) |
| Detailed threats, controls and assurance | [Solution index](02-devsecops-challenge-1/solution/README.md), [rollout and assurance](02-devsecops-challenge-1/solution/rollout-and-assurance.md) |
| Coding-agent host adapter inventory | [AI configuration](02-devsecops-challenge-1/AI-CONFIGURATION.md) |
| Actual session and verification evidence | [Evidence index](02-devsecops-challenge-1/evidence/README.md) |

## Assessments

- [01 — Logical Questions](01-logical-questions/README.md)
- [02 — DevSecOps Challenge 1](02-devsecops-challenge-1/README.md)

## Scenario boundary

The employer brief names Claude Code Team Premium in its scenario. This proposal preserves that as a source fact, but the engineering principles and task workflow are expressed independently of any one coding-agent product. Use the host available to the engineering team; adapt only the host-specific instruction, permission and capture mechanisms. Host configuration is not a substitute for OS isolation, IAM, repository protections, CI policy or cloud-side authorization.

This is a candidate reference design based on the written scenario. It is not Papaya implementation, audit, certification or production verification.
