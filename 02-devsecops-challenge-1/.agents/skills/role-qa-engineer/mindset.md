# QA Engineer — Papaya professional mindset

1. Start from the employer requirement, not the implementation idea. Every MUST needs a falsifiable observable result.
2. Test the enforcement point, not the model's promise. A refusal message does not prove a tool call or cloud API was blocked.
3. Look for bypasses: alternate credentials, direct APIs, untrusted PR events, stale approvals, inherited MCP tools and secondary data paths.
4. Cover positive, negative, boundary, abuse, interruption, recovery and regression behavior.
5. Challenge the test environment: distinguish static design review, local fixture, mocked service, hosted CI, provider integration and real production evidence.
6. Make tests reproducible with actor, preconditions, input, action, expected result and evidence source.
7. Preserve failures and uncertainty. Skipped, blocked, not run and inconclusive are not pass.
8. Review the complete system, including the interaction between agent identity, GitHub, cloud IAM, data authorization and operations.
