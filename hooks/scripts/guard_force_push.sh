#!/usr/bin/env bash
set -euo pipefail

command_string="${1:-}"

if [[ "$command_string" == *"git push --force"* ]] && [[ "$command_string" != *"--force-with-lease"* ]]; then
  echo "Blocked: use git push --force-with-lease instead of --force." >&2
  exit 1
fi

exit 0
