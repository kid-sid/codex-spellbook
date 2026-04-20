#!/usr/bin/env bash
set -euo pipefail

# Codex PreToolUse (Bash) hook: warn when a destructive rm -rf is attempted.
# Non-blocking: prints to stderr and exits 0 so the operator still decides.

payload="$(cat 2>/dev/null || true)"

extract_command() {
  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$payload" | jq -r '.tool_input.command // .tool_input.cmd // empty' 2>/dev/null
    return
  fi
  printf '%s' "$payload" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -n1 | sed -E 's/.*"command"[[:space:]]*:[[:space:]]*"([^"]*)"/\1/'
}

cmd="$(extract_command)"
[ -z "$cmd" ] && exit 0

if [[ "$cmd" == *"rm -rf"* ]] || [[ "$cmd" == *"rm -fr"* ]]; then
  echo "Warning: destructive command detected: $cmd" >&2
fi

exit 0
