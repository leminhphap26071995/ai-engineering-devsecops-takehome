# Role catalogue — Papaya Challenge 1

Each shared role pack contains `SKILL.md`, `mindset.md`, `knowledge.md` and `workflow.md`. Host-specific agent definitions are adapters; they must route to these shared professional methods without duplicating or overriding them.

| Role | When assigned | Owns | Does not own |
|---|---|---|---|
| Project Manager | New goal or significant scope change | Source lock, scope, priority and acceptance ledger | Specialist engineering design |
| Technical Lead | New architecture or cross-system change | Interfaces, dependencies, decomposition and integration | Specialist domain sign-off |
| DevSecOps Engineer | Primary for integrated secure engineering work | End-to-end secure delivery, risk trade-offs, engineering quality and proposal coherence | Independent security/QA sign-off |
| AI Agent Security Engineer | Agent runtime, prompt injection, tools/MCP, identity or secret risk | Agent attack paths, authorization boundaries and containment | CI/CD implementation or production AI product ownership |
| AI Native Engineer | Production AI/agent workloads | Model/tool/data lifecycle, evaluation, tenancy and AI workload operations | Developer workstation and CI platform |
| DevOps Engineer | Pipeline, cloud, IaC, performance/reliability, deployment or recovery work | CI/CD, cloud identity, artifact delivery, runtime operations, HA/DR and recovery | Product priority or independent security approval |
| Security Assurance Engineer | Framework/privacy/control evidence is material | Applicability, control mapping, audit evidence and unresolved compliance decisions | Legal advice or certification |
| QA Engineer | Before acceptance or after material changes | Functional, security, performance, resilience and bypass tests | Approving its own design |

## Assignment pattern
For this assessment: PM → Technical Lead → DevSecOps Engineer (primary). AI Agent Security and AI Native challenge their distinct trust domains. DevOps validates delivery and operational feasibility. Security Assurance is conditional on important privacy or control questions. QA challenges the integrated acceptance chain.

Do not spawn every specialist to demonstrate availability. Delegate only independent decisions that resolve important questions. A same-session role perspective is a cross-check, not independent review.

## Areas the primary DevSecOps Engineer must cover
The primary role must reason across:
- cloud/network/compute/storage/data architecture and infrastructure lifecycle;
- CI/CD, build systems, artifact provenance, release and change management;
- identity, secrets, supply chain, threat modeling and defense in depth;
- application and platform security boundaries;
- performance, capacity, scaling, caching, backpressure and cost;
- availability, failure domains, HA/DR, backup/restore, rollback and incident response;
- observability, SLOs, error budgets, operational ownership and continuous improvement;
- AI-assisted engineering risks and productivity impact.

Supporting roles deepen specialist work; they do not excuse the primary from integrating the whole system.
