# Operating model — engineering team and coding-agent support

## 1. Engineering plane
The engineering system owns the actual product and platform outcomes: infrastructure, cloud services, application architecture, CI/CD, supply chain, identity, security, performance, availability, resilience, observability, incident response, recovery and cost.

## 2. Coding-agent support
Coding agents help engineers understand systems, prepare changes and run checks. They do not have separate authority to approve production work. A model response, role prompt or tool description cannot grant permissions.

## Accountability

| Responsibility | Accountable role | Decision right |
|---|---|---|
| Goal, scope, requirements and acceptance | Project Manager | Baseline or return unclear requirements to owner |
| Architecture, dependencies and decomposition | Technical Lead | Resolve interfaces, sequencing and architecture conflicts |
| Integrated secure engineering design | DevSecOps Engineer | Own end-to-end design across delivery, security and operations |
| Coding-agent runtime, identity, tool abuse and prompt injection | AI Agent Security Engineer | Threat-model and challenge agent-specific controls |
| Production AI lifecycle, model/tool/data flow and tenancy | AI Native Engineer | Own production AI architecture and evaluation boundaries |
| CI/CD, cloud identity, IaC, deployment, reliability and recovery | DevOps Engineer | Prove delivery and operational feasibility |
| Control applicability, privacy and audit evidence | Security Assurance Engineer | Map evidence and identify legal/privacy-owner decisions |
| Tests and acceptance criteria | QA Engineer | Challenge functional, security, performance and recovery acceptance |
| Candidate-specific facts and submission | Candidate | Verify personal claims and authorize submission |

## Senior engineering task contract
Every substantive task should provide or derive:
- desired outcome, user/customer impact and affected system;
- source revision, environment and known architecture;
- constraints, dependencies, ownership and non-goals;
- data classification, threat surface and change risk;
- performance/SLO and availability requirements where applicable;
- expected implementation, rollback and acceptance evidence.

The agent must not invent missing topology, SLO, RTO/RPO or capacity baselines. It should inspect available evidence and mark unresolved values UNKNOWN.

## How a coding agent should work
The agent should:
1. clarify the outcome and how success will be checked before choosing a tool or editing YAML;
2. discover the actual implementation and ownership boundaries;
3. trace request/data/control flow and identify dependencies, critical paths and failure domains;
4. establish baseline metrics before proposing performance changes;
5. identify threats, blast radius, reversibility and operational consequences;
6. compare options across security, latency, throughput, availability, recovery, cost and engineering friction;
7. propose the smallest complete change that satisfies acceptance;
8. act only within the granted environment and tool permissions;
9. verify real behavior, including negative and failure-path tests;
10. record the decision, supporting evidence and any remaining risks.

## Review and disagreement
Specialists challenge only within their domain and return: requirement, evidence, counterexample, affected boundary, enforcement/implementation point, test and pass criteria, trade-offs and unknowns. The primary integrates findings and records accepted/rejected/deferred/unknown. Technical Lead resolves architecture conflicts; PM resolves scope/priority; candidate resolves personal factual claims.

## What each evidence status means
Source fact, candidate statement, recommendation, inference, proposed test, executed test, provider observation and candidate acceptance are distinct. A green unit test is not production acceptance; a valid configuration file is not proof that the running system uses it.
