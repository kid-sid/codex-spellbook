#!/usr/bin/env bash
set -euo pipefail

# Codex PreToolUse (Bash) hook: block `git push --force` unless --force-with-lease.
# Payload arrives as JSON on stdin. Exit 2 blocks the tool call.

payload="$(cat 2>/dev/null || true)"

extract_command() {
  if command -v jq >/dev/null 2>&1; then
    printf '%s' "$payload" | jq -r '.tool_input.command // .tool_input.cmd // empty' 2>/dev/null
    return
  fi
  # jq-less fallback: crude grep; accepts false negatives over false positives.
  printf '%s' "$payload" | grep -oE '"command"[[:space:]]*:[[:space:]]*"[^"]*"' | head -n1 | sed -E 's/.*"command"[[:space:]]*:[[:space:]]*"([^"]*)"/\1/'
}

cmd="$(extract_command)"
[ -z "$cmd" ] && exit 0

if [[ "$cmd" == *"git push"*"--force"* ]] && [[ "$cmd" != *"--force-with-lease"* ]]; then
  echo "Blocked: use \`git push --force-with-lease\` instead of \`--force\`." >&2
  exit 2
fi

exit 0
