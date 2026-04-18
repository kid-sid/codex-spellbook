#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  exit 0
fi

if ! command -v markdownlint >/dev/null 2>&1; then
  exit 0
fi

for file in "$@"; do
  case "$file" in
    *.md) markdownlint --fix "$file" >/dev/null 2>&1 || true ;;
  esac
done
