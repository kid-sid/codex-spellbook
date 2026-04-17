from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]
AGENTS_DIR = ROOT / "agents"


def main() -> int:
    errors: list[str] = []
    files = sorted(AGENTS_DIR.glob("*.agents.md"))

    if not files:
        errors.append("No agent template files found.")

    for path in files:
        text = path.read_text(encoding="utf-8")
        rel = path.relative_to(ROOT)
        line_count = len(text.splitlines())

        if not text.strip():
            errors.append(f"{rel}: file is empty.")
        if line_count < 50:
            errors.append(f"{rel}: file must be at least 50 lines; found {line_count}.")

    if errors:
        print("\n".join(errors))
        return 1

    print(f"Validated {len(files)} agent templates.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
