from __future__ import annotations

from pathlib import Path


ROOT = Path(__file__).resolve().parents[1]


def count(pattern: str) -> int:
    return len(list(ROOT.glob(pattern)))


print(f"skills={count('skills/*/SKILL.md')}")
print(f"task_prompts={count('task-prompts/**/*.md')}")
print(f"agent_templates={count('agents/*.agents.md')}")
