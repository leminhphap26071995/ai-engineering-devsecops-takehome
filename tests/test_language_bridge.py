import io
import json
import subprocess
import tempfile
import unittest
from pathlib import Path
from unittest.mock import patch
import sys

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
from scripts import language_bridge as bridge


class LanguageBridgeTests(unittest.TestCase):
    def test_critical_tokens_keep_ids_numbers_urls_and_acronyms(self):
        values = bridge.critical_tokens("OIDC AWS PR-42 2026-11-11 90% https://example.com/x")
        for token in ("OIDC", "AWS", "PR-42", "2026-11-11", "90%"):
            self.assertIn(token, values)
        self.assertTrue(any(item.startswith("https://") for item in values))

    def test_auto_language_uses_only_verified_model_profile(self):
        with tempfile.TemporaryDirectory() as tmp:
            profile = Path(tmp) / "profiles.json"
            profile.write_text(json.dumps({"profiles": {"model-a": {
                "benchmark_status": "PLANNED", "agent_language": "en"
            }}}), encoding="utf-8")
            self.assertEqual(bridge.choose_agent_language("auto", "model-a", str(profile)), "same-as-source")
            profile.write_text(json.dumps({"profiles": {"model-a": {
                "benchmark_status": "VERIFIED", "agent_language": "en"
            }}}), encoding="utf-8")
            self.assertEqual(bridge.choose_agent_language("auto", "model-a", str(profile)), "en")

    def test_prepare_persists_raw_and_context(self):
        envelope = {
            "source_language": "vi", "agent_language": "vi", "response_language": "vi",
            "goal": "Fix OIDC 403", "intent": "debug", "scope": ["OIDC"],
            "non_goals": [], "acceptance": [{"id":"REQ-1","priority":"MUST","statement":"preserve access","source":"user-input"}],
            "constraints": [], "decisions": [], "evidence": [], "unknowns": [],
            "source_refs": ["user-input"], "next_action": "inspect logs", "critical_tokens": ["OIDC", "403"]
        }
        with tempfile.TemporaryDirectory() as tmp:
            args = type("Args", (), {
                "state_dir": tmp, "input": "-", "agent_language": "auto",
                "user_language": None, "model_id": None, "language_profiles": None,
                "translator_model": None, "timeout": 10
            })()
            with patch("sys.stdin", io.StringIO("Kiểm tra OIDC 403.")), \
                 patch.object(bridge, "helper_call", return_value=envelope), \
                 patch("sys.stdout"):
                self.assertEqual(bridge.prepare(args), 0)
            self.assertEqual(len(list((Path(tmp) / "raw").glob("*.txt"))), 1)
            contexts = list((Path(tmp) / "context").glob("*.json"))
            self.assertEqual(len(contexts), 1)
            saved = json.loads(contexts[0].read_text(encoding="utf-8"))
            self.assertEqual(saved["agent_language"], "vi")
            self.assertTrue(Path(saved["agent_output_path"]).parent.exists())

    def test_finalize_rejects_dropped_critical_token(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = bridge.state_root(tmp)
            task = "task-1"
            (root / "context" / f"{task}.json").write_text(json.dumps({
                "response_language": "vi", "agent_language": "en", "context": {}, "agent_output_path": str(root / "outbox" / "answer.json")
            }), encoding="utf-8")
            answer_path = root / "outbox" / "answer.json"
            answer_path.write_text(json.dumps({
                "answer": "OIDC is required.", "source_language": "en",
                "evidence": [], "uncertainties": [], "critical_tokens": ["OIDC"]
            }), encoding="utf-8")
            args = type("Args", (), {
                "state_dir": tmp, "task_id": task, "answer_file": str(answer_path),
                "translator_model": None, "max_words": 30, "max_sentences": 5, "timeout": 10
            })()
            with patch.object(bridge, "helper_call", return_value={
                "answer": "Cần xác thực.", "language": "vi", "meaning_preserved": True,
                "uncertainties_preserved": True, "negation_preserved": True,
                "preserved_critical_tokens": []
            }):
                with self.assertRaisesRegex(bridge.BridgeError, "CRITICAL_TOKEN"):
                    bridge.finalize(args)

    def test_finalize_never_truncates_over_limit(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = bridge.state_root(tmp)
            task = "task-2"
            answer_path = root / "outbox" / "answer.json"
            (root / "context" / f"{task}.json").write_text(json.dumps({
                "response_language": "vi", "agent_language": "en", "context": {}, "agent_output_path": str(answer_path)
            }), encoding="utf-8")
            answer_path.write_text(json.dumps({
                "answer": "The cause is a missing permission.", "source_language": "en",
                "evidence": [], "uncertainties": [], "critical_tokens": []
            }), encoding="utf-8")
            args = type("Args", (), {
                "state_dir": tmp, "task_id": task, "answer_file": str(answer_path),
                "translator_model": None, "max_words": 5, "max_sentences": 5, "timeout": 10
            })()
            long_text = "Một câu trả lời dài hơn giới hạn nhưng giữ nguyên toàn bộ nội dung cần thiết."
            translated = {
                "answer": long_text, "language": "vi", "meaning_preserved": True,
                "uncertainties_preserved": True, "negation_preserved": True,
                "preserved_critical_tokens": []
            }
            with patch.object(bridge, "helper_call", return_value=translated), patch("sys.stdout"):
                self.assertEqual(bridge.finalize(args), 0)
            final = json.loads(next((root / "final").glob("*.json")).read_text(encoding="utf-8"))
            self.assertEqual(final["status"], "OVER_LIMIT_PRESERVED")
            self.assertEqual(final["answer"], long_text)

    def test_helper_uses_read_only_isolated_codex_exec(self):
        with tempfile.TemporaryDirectory() as tmp:
            root = bridge.state_root(tmp)
            seen = {}
            def fake_run(command, **kwargs):
                seen["command"] = command
                output = Path(command[command.index("--output-last-message") + 1])
                output.write_text('{"ok": true}', encoding="utf-8")
                return subprocess.CompletedProcess(command, 0, '{"type":"turn.completed"}\n', "")
            with patch.object(bridge.shutil, "which", return_value="/usr/bin/codex"), \
                 patch.object(bridge.subprocess, "run", side_effect=fake_run):
                self.assertTrue(bridge.helper_call(
                    "test", {"type": "object", "properties": {}, "required": []},
                    root, "task", "prepare", None, 10
                )["ok"])
            command = seen["command"]
            self.assertIn("--sandbox", command)
            self.assertIn("read-only", command)
            self.assertIn("--skip-git-repo-check", command)
            self.assertNotIn("--yolo", command)

    def test_multilingual_negation_is_detected(self):
        self.assertTrue(bridge.NEGATION.search("Không được cấp quyền production."))
        self.assertTrue(bridge.NEGATION.search("The agent must not deploy directly."))


if __name__ == "__main__":
    unittest.main()
