#!/usr/bin/env bash
set -euo pipefail

command_string="${1:-}"

if [[ "$command_string" == *"rm -rf"* ]]; then
  echo "Warning: destructive command detected: $command_string" >&2
fi

exit 0
