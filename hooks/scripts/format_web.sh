#!/usr/bin/env bash
set -euo pipefail

if [ "$#" -eq 0 ]; then
  exit 0
fi

if ! command -v prettier >/dev/null 2>&1; then
  exit 0
fi

for file in "$@"; do
  case "$file" in
    *.js|*.jsx|*.ts|*.tsx|*.json|*.md|*.css|*.scss|*.html|*.yml|*.yaml)
      prettier --write "$file" >/dev/null 2>&1 || true
      ;;
  esac
done
