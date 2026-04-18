# Hooks

This repo ships reusable hook scripts for common Codex workflows:

- format files after edits
- block unsafe git pushes
- warn on destructive shell commands
- run repo validation after markdown changes

## Important

Codex hook configuration can vary by runtime and version. This repo therefore ships hook scripts, not a single hard-coded config file.

Use these scripts by pointing your Codex hook events at the commands below.

## Available Scripts

| Script | Use For |
| --- | --- |
| `hooks/scripts/format_markdown.sh` | Format markdown files with `markdownlint --fix` when available |
| `hooks/scripts/format_python.sh` | Format Python files with `ruff --fix` and `black` when available |
| `hooks/scripts/format_web.sh` | Format JS, TS, JSON, and Markdown files with `prettier --write` when available |
| `hooks/scripts/guard_force_push.sh` | Block `git push --force` unless `--force-with-lease` is used |
| `hooks/scripts/warn_rm_rf.sh` | Print a warning when a destructive `rm -rf` command is attempted |
| `hooks/scripts/validate_spellbook.sh` | Run local spellbook validation scripts when Python is available |

## Setup

### 1. Copy the scripts into the target project

```bash
cp -r hooks /path/to/your-project/
```

### 2. Point your Codex hook config at the scripts you want

Examples:

```bash
bash hooks/scripts/format_markdown.sh README.md
bash hooks/scripts/format_python.sh src/app.py
bash hooks/scripts/format_web.sh src/server.ts
bash hooks/scripts/guard_force_push.sh "git push --force origin main"
bash hooks/scripts/warn_rm_rf.sh "rm -rf build/"
bash hooks/scripts/validate_spellbook.sh
```

### 3. Start simple

Recommended first set:

- format Markdown after edits
- format Python or web files after edits
- block `git push --force`
- warn on `rm -rf`

## Suggested Mapping

| Event Type | Script |
| --- | --- |
| post-edit markdown | `format_markdown.sh` |
| post-edit python | `format_python.sh` |
| post-edit web files | `format_web.sh` |
| pre-shell command | `guard_force_push.sh`, `warn_rm_rf.sh` |
| post-edit repo docs | `validate_spellbook.sh` |

## Notes

- All scripts are safe no-ops when required tools are missing.
- `validate_spellbook.sh` checks for `python3`, then `python`, and skips validation if neither exists.
- The guard scripts operate on the shell command string you pass in.
