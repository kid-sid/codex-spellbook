from __future__ import annotations

from pathlib import Path
import re
import sys


ROOT = Path(__file__).resolve().parents[1]
SKILLS_DIR = ROOT / "skills"
FRONTMATTER_RE = re.compile(r"\A---\n(.*?)\n---\n", re.DOTALL)
CHECKLIST_ITEM_RE = re.compile(r"^- \[ \] .+", re.MULTILINE)


def require(condition: bool, message: str, errors: list[str]) -> None:
    if not condition:
        errors.append(message)


def main() -> int:
    errors: list[str] = []
    files = sorted(SKILLS_DIR.glob("*/SKILL.md"))
    require(bool(files), "No skill files found.", errors)

    for path in files:
        text = path.read_text(encoding="utf-8")
        match = FRONTMATTER_RE.match(text)
        rel = path.relative_to(ROOT)

        require(match is not None, f"{rel}: missing YAML frontmatter.", errors)
        if match is None:
            continue

        frontmatter = match.group(1)
        for field in ("name:", "description:"):
            require(field in frontmatter, f"{rel}: missing frontmatter field `{field[:-1]}`.", errors)

        folder_name = path.parent.name
        require(f"name: {folder_name}" in frontmatter, f"{rel}: frontmatter name must match folder name `{folder_name}`.", errors)
        require("## When to Activate" in text, f"{rel}: missing `## When to Activate` section.", errors)
        require("## Checklist" in text, f"{rel}: missing `## Checklist` section.", errors)
        require(CHECKLIST_ITEM_RE.search(text) is not None, f"{rel}: checklist must include at least one unchecked item.", errors)

    if errors:
        print("\n".join(errors))
        return 1

    print(f"Validated {len(files)} skill files.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
