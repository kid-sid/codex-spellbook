from __future__ import annotations

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
PROMPTS_DIR = ROOT / "task-prompts"
FRONTMATTER_RE = re.compile(r"\A---\n(.*?)\n---\n", re.DOTALL)


def main() -> int:
    errors: list[str] = []
    files = sorted(PROMPTS_DIR.glob("**/*.md"))

    if not files:
        errors.append("No task prompt files found.")

    for path in files:
        text = path.read_text(encoding="utf-8").strip()
        rel = path.relative_to(ROOT)

        if not text:
            errors.append(f"{rel}: file is empty.")
            continue

        match = FRONTMATTER_RE.match(text + "\n")
        if match is None:
            errors.append(f"{rel}: missing YAML frontmatter.")
            continue

        frontmatter = match.group(1)
        for field in ("name:", "description:", "category:"):
            if field not in frontmatter:
                errors.append(f"{rel}: missing frontmatter field `{field[:-1]}`.")

    if errors:
        print("\n".join(errors))
        return 1

    print(f"Validated {len(files)} task prompt files.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
