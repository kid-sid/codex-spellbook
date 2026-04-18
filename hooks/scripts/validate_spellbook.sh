#!/usr/bin/env bash
set -euo pipefail

if command -v python3 >/dev/null 2>&1; then
  python3 scripts/validate_skills.py
  python3 scripts/validate_task_prompts.py
  python3 scripts/validate_agent_templates.py
  python3 scripts/lint_markdown.py
  exit 0
fi

if command -v python >/dev/null 2>&1; then
  python scripts/validate_skills.py
  python scripts/validate_task_prompts.py
  python scripts/validate_agent_templates.py
  python scripts/lint_markdown.py
  exit 0
fi

echo "Skipping validation: Python is not available on PATH." >&2
exit 0
