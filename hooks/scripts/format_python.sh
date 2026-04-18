#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  exit 0
fi

for file in "$@"; do
  case "$file" in
    *.py)
      if command -v ruff >/dev/null 2>&1; then
        ruff check --fix "$file" >/dev/null 2>&1 || true
      fi
      if command -v black >/dev/null 2>&1; then
        black "$file" >/dev/null 2>&1 || true
      fi
      ;;
  esac
done
