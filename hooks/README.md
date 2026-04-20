# Hooks

Codex CLI exposes two extensibility mechanisms that this repo targets:

| Mechanism | Status | Events | Config |
| --- | --- | --- | --- |
| `hooks.json` | Experimental, gated | `SessionStart`, `PreToolUse`, `PostToolUse`, `UserPromptSubmit`, `Stop` | `~/.codex/hooks.json` or `<repo>/.codex/hooks.json` |
| `notify` | Stable | `agent-turn-complete` only | `notify = [...]` in `~/.codex/config.toml` |

Scripts in `hooks/scripts/` are the executables; the wiring that invokes them lives in `hooks/hooks.json` (for hook events) or `config.toml` (for notify).

## Limits to know

- `PreToolUse` and `PostToolUse` currently match the **Bash** tool only. Format-on-edit style hooks will not fire on file writes; use `pre-commit` or a `Makefile` target instead.
- Hook scripts receive a JSON payload on **stdin** (fields include `session_id`, `cwd`, `hook_event_name`, `tool_input`, `turn_id`). They do not receive shell arguments the way CI hooks often do.
- `hooks.json` requires enabling in `config.toml`:
  ```toml
  [features]
  codex_hooks = true
  ```
- Exit code `2` from a `PreToolUse` hook blocks the tool call. Exit code `0` allows it. Non-zero other codes surface as errors.

## Available Scripts

| Script | Intended Event | Use For |
| --- | --- | --- |
| `hooks/scripts/guard_force_push.sh` | `PreToolUse` (Bash) | Block `git push --force` unless `--force-with-lease` is used |
| `hooks/scripts/warn_rm_rf.sh` | `PreToolUse` (Bash) | Print a warning when `rm -rf` is attempted |
| `hooks/scripts/validate_spellbook.sh` | `Stop` | Run repo validation scripts at the end of a turn |
| `hooks/scripts/format_markdown.sh` | **Not a Codex hook** - use `pre-commit` or `make` | `markdownlint --fix` |
| `hooks/scripts/format_python.sh` | **Not a Codex hook** - use `pre-commit` or `make` | `ruff --fix` + `black` |
| `hooks/scripts/format_web.sh` | **Not a Codex hook** - use `pre-commit` or `make` | `prettier --write` |

## Setup

### 1. Copy the config and scripts into the target project

```bash
mkdir -p /path/to/project/.codex
cp hooks/hooks.json /path/to/project/.codex/hooks.json
cp -r hooks/scripts /path/to/project/.codex/
```

Or install globally:

```bash
mkdir -p "$HOME/.codex"
cp hooks/hooks.json "$HOME/.codex/hooks.json"
cp -r hooks/scripts "$HOME/.codex/"
```

### 2. Enable hooks in config.toml

```toml
# ~/.codex/config.toml
[features]
codex_hooks = true
```

### 3. Wire up notify separately (optional)

```toml
# ~/.codex/config.toml
notify = ["bash", "/path/to/on-turn-complete.sh"]
```

The `notify` program receives the event JSON as `argv[1]` (a single argument), not on stdin. Fields: `type`, `thread-id`, `turn-id`, `cwd`, `input-messages`, `last-assistant-message`.

## Format-on-edit alternative

Do not wire `format_markdown.sh` / `format_python.sh` / `format_web.sh` to `hooks.json`. They will never fire because Codex file edits don't go through Bash. Use `pre-commit`:

```yaml
# .pre-commit-config.yaml (example)
repos:
  - repo: https://github.com/pre-commit/mirrors-prettier
    rev: v3.1.0
    hooks:
      - id: prettier
```

Or invoke them manually:

```bash
bash hooks/scripts/format_python.sh src/app.py
```

## Notes

- All scripts are safe no-ops when required tools are missing.
- `validate_spellbook.sh` checks for `python3`, then `python`, and skips validation if neither exists.
- Hook scripts are idempotent and safe to re-run.
