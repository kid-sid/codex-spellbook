from __future__ import annotations

from pathlib import Path
import sys


ROOT = Path(__file__).resolve().parents[1]


def iter_markdown_files() -> list[Path]:
    return sorted(
        path
        for path in ROOT.glob("**/*.md")
        if ".git" not in path.parts
    )


def main() -> int:
    errors: list[str] = []

    for path in iter_markdown_files():
        rel = path.relative_to(ROOT)
        lines = path.read_text(encoding="utf-8").splitlines()

        for index, line in enumerate(lines, start=1):
            if line.endswith(" "):
                errors.append(f"{rel}:{index}: trailing whitespace.")
            if "\t" in line:
                errors.append(f"{rel}:{index}: tab character found; use spaces.")

        if lines and lines[0].strip() == "":
            errors.append(f"{rel}: file starts with a blank line.")

    if errors:
        print("\n".join(errors))
        return 1

    print(f"Linted {len(iter_markdown_files())} markdown files.")
    return 0


if __name__ == "__main__":
    sys.exit(main())
