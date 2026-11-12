# Reference standards and implementation guidance

This is a design reference list, not a compliance mapping or certification claim. Verify current edition, applicability and contractual scope before implementation.

| Reference | Relevance | How this design uses it | Boundary |
|---|---|---|---|
| NIST SP 800-218 SSDF v1.1 | Secure software development across preparation, protection, production and vulnerability response | Requirements, protected source/build, secure release and response lifecycle | Final guidance, not product checklist or certification |
| NIST SP 800-218A | Secure software development practices for generative AI and dual-use foundation models | AI development lifecycle, model/system security and evaluation considerations | Final SSDF community profile; applicability depends on the workload |
| NIST SP 800-218 Rev.1 initial public draft (Dec 2025) | Proposed SSDF updates | Monitor as draft input | Draft only; re-check publication status |
| OWASP Top 10 for Agentic Applications 2026 | Agent goal hijack, tool misuse, identity/privilege abuse, agentic supply chain, code execution, memory/context poisoning, inter-agent communication, cascading failures, human-agent trust exploitation and rogue agents | Threat crosswalk and adversarial tests AT-02, AT-03, AT-11, AT-12, AT-20, AT-22–AT-27 | Risk taxonomy, not proof of mitigation |
| OWASP Top 10 for LLM Applications 2026 | Prompt injection, sensitive disclosure, supply chain, output handling, excessive agency, vector weakness and unbounded consumption | Production AI and retrieval threat themes | Risk taxonomy, not proof of mitigation |
| OWASP Agentic Skills Top 10 (2026) | Risks in agent skill packages and their instruction/tool behavior | Treat skills as a versioned instruction supply-chain input; review provenance, permissions and changes | Emerging project guidance; not an assurance certification |
| NIST AI RMF 1.0 + NIST AI 600-1 GenAI Profile | Govern/map/measure/manage AI risks across lifecycle | AI use-case inventory, context/data governance, evaluation and monitoring | Voluntary risk framework; legal applicability is separate |
| SLSA v1.2 Build Provenance | Verifiable information about where/how artifacts were built | Build provenance, immutable artifact digest and verification before promotion | Do not claim a SLSA level without evidence |
| GitHub Actions security guidance | Pinned workflow dependencies, OIDC and artifact attestations | CI permissions, protected deployment and provenance | Feature availability depends on repository plan/config |
| AWS IAM OIDC guidance | Restrict trusted subject claims to repository/ref/workflow | Narrow AWS deploy-role trust and separate identities | Validate exact claim shape in real workflow |
| Google Workload Identity Federation | Federated access without service-account key distribution | GCP deployment/model workload identity | Separate pools/providers and IAM scopes by purpose |
| Kubernetes Pod Security Standards | Baseline/restricted pod hardening and admission modes | k0s workload admission, audit/warn/enforce rollout | Verify Kubernetes version and k0s support |

## Primary links
- NIST SSDF v1.1: https://csrc.nist.gov/pubs/sp/800/218/final
- NIST SSDF SP 800-218A: https://csrc.nist.gov/pubs/sp/800/218/a/final
- NIST SSDF project and SP 800-218A: https://csrc.nist.gov/projects/SSDF
- NIST SSDF Rev.1 initial public draft: https://csrc.nist.gov/pubs/sp/800/218/r1/ipd
- OWASP Top 10 for Agentic Applications 2026: https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/
- OWASP GenAI LLM Top 10: https://genai.owasp.org/llm-top-10/
- OWASP Agentic Skills Top 10: https://owasp.org/projects/agentic-skills-top-10
- NIST AI RMF GenAI Profile: https://www.nist.gov/publications/artificial-intelligence-risk-management-framework-generative-artificial-intelligence
- SLSA v1.2 Build Provenance: https://slsa.dev/spec/v1.2/build-provenance
- GitHub Actions security: https://docs.github.com/en/actions/how-tos/secure-your-work
- AWS OIDC roles: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_create_for-idp_oidc.html
- Google Workload Identity Federation: https://docs.cloud.google.com/iam/docs/workload-identity-federation
- Kubernetes Pod Security Standards: https://kubernetes.io/docs/concepts/security/pod-security-standards/

## Applicability notes
- NIST SP 800-218 v1.1 is final; Rev.1 initial public draft is not a final standard.
- OWASP LLM Top 10 is a threat taxonomy. Listing a category does not prove mitigation.
- SLSA levels require evidence about source/build infrastructure and provenance. This document proposes provenance verification but does not claim a level.
- ISO/IEC 27001, HIPAA and country-specific privacy obligations require scoped legal/privacy analysis, contractual review and evidence. This reference design does not claim compliance.
