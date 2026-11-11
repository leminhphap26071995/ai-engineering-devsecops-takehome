# Cursor Local Transcript Capture — Windows

## Purpose and hard gate

Papaya requires every coding-agent session used for Challenge 1 to be included as a complete, raw, unedited conversation. This guide uses Cursor's local desktop Agent and preserves the native session directory before the substantive assessment session begins.

Cursor's transcript path is version-dependent and is not a stable public export contract. Cursor community/support posts report local JSONL transcripts under:

~~~text
%USERPROFILE%\.cursor\projects\<workspace-slug>\agent-transcripts\<session-id>\
~~~

Treat this as a discovery hypothesis, not proof. The harmless probe below verifies the installed build on this Windows machine.

## 1. Install and configure Cursor

1. Download Cursor Desktop from https://cursor.com/download.
2. Optionally import VS Code settings/extensions through Cursor's import flow.
3. Open the repository as a **local folder** in Cursor.
4. Use the local Agent panel (Ctrl+I). Do not use Cloud Agents or Cursor Projects for the assessment transcript sessions.
5. Enable Privacy Mode. This prevents code from being used for model training, but prompts and code context are still processed by Cursor and its model providers. Do not use real customer/claim data, credentials or private employer data.
6. In Settings → Agents → Approvals & Execution, do not select Run Everything. Auto-review is a convenience guardrail, not a hard security boundary. For stricter control, use Allowlist and approve only the commands required.
7. Do not connect unnecessary MCP servers. Do not open a shell with production AWS/GCP credentials, personal cloud sessions or sensitive files available to the agent.

Windows note: Cursor's shell sandbox support may depend on the Windows/WSL2 execution path and installed version. Git Bash is a shell, not an OS security sandbox. Do not infer isolation merely because the terminal is Git Bash.

## 2. Run a harmless capture probe

Before any substantive Challenge 1 work, create a local Agent chat in this repository and send:

~~~text
This is a transcript-capture verification probe only.
Do not edit, create, delete or rename any files.
Do not run terminal commands.
Do not call MCP tools or access external services.
Read only the root README.md and report its title plus one repository safety rule.
~~~

Confirm the answer is visible in the Agent conversation. End the chat, then close Cursor completely so transcript files are flushed.

## 3. Discover the local transcript

From the repository root, use PowerShell:

~~~powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\03-ai-agent-evidence\windows\List-CursorSessions.ps1
~~~

Or Git Bash:

~~~bash
find "$HOME/.cursor/projects" -type f -path '*/agent-transcripts/*/*.jsonl' -print
~~~

The PowerShell script lists candidate session directories, JSONL files, sizes and timestamps. Identify the session that matches the harmless probe and the repository workspace. Do not assume the newest file is necessarily the right session.

## 4. Copy the native session directory unchanged

With Cursor fully closed, run:

~~~powershell
powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\03-ai-agent-evidence\windows\Capture-CursorSession.ps1 -SessionDirectory 'C:\Users\<you>\.cursor\projects\<workspace>\agent-transcripts\<session-id>'
~~~

The script:
- requires the source directory to be inside the Cursor projects directory;
- requires Cursor to be closed;
- copies the complete session directory without parsing or rewriting its contents;
- refuses to overwrite an existing capture;
- computes SHA-256 hashes for the copied files and writes a separate capture manifest.

Review the copied directory under 03-ai-agent-evidence/raw/cursor/. Keep original JSONL and any companion native session files unchanged.

## 5. Verify and preserve

- Confirm at least one JSONL transcript exists in the captured directory.
- Open a copy for inspection and verify it contains the harmless probe request and response. Do not edit the original.
- Compare source and copied file hashes in the capture manifest.
- Add the session to session-manifest.md with purpose = capture-probe, workspace, session ID, relative path, SHA-256 and capture date.
- Commit the raw transcript and manifest in the same repository as the assessment.
- If a transcript contains credentials, personal data or other sensitive material, do not publish it. Stop and resolve a safe, employer-acceptable capture approach; do not silently redact the raw file.

## 6. Substantive assessment sessions

Only after the probe is captured and inspected:
1. Start a fresh local Cursor Agent chat.
2. Ask it to review the challenge source, current architecture, threat model, IaC decision and acceptance tests.
3. Require it to challenge assumptions, identify missing enforcement points and propose concrete edits.
4. Review its diff; reject unsupported claims and unnecessary scope.
5. Close Cursor and capture that complete session directory with the same script.
6. Record every session used, including any separately invoked subagent session. Do not reconstruct or summarize in place of raw transcripts.

## References and provenance

- [Cursor Agent mode](https://cursor.com/help/ai-features/agent)
- [Cursor Privacy and data](https://cursor.com/help/security-and-privacy/privacy)
- [Cursor Run Modes](https://cursor.com/docs/agent/security/run-modes)
- [Cursor Terminal integration](https://prod.cursor.com/help/ai-features/terminal)
- [Cursor community report: local agent-transcripts path](https://forum.cursor.com/t/cant-access-chat-history-since-latest-update/158688/8)

Cursor's forum/support guidance reports local transcript files and notes that transcript persistence can be affected by application crashes or updates. Close the application cleanly and capture the files promptly. The capture probe is the verification for the installed version.
