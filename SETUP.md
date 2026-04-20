# Setup Guide

Three paths depending on how widely you want the spellbook available.

---

## Option A — Personal global install (recommended starting point)

Everything available in every repo you open, zero per-project config needed.

```bash
# 1. Clone the spellbook
git clone https://github.com/kid-sid/codex-spellbook.git
cd codex-spellbook

# 2. Install all skills
mkdir -p "$HOME/.agents/skills"
cp -r skills/* "$HOME/.agents/skills/"

# 3. Enable hooks globally
mkdir -p "$HOME/.codex"
cp hooks/hooks.json "$HOME/.codex/hooks.json"
cp -r hooks/scripts "$HOME/.codex/"

# 4. Enable the hooks feature in config.toml
cat >> "$HOME/.codex/config.toml" << 'EOF'

[features]
codex_hooks = true
EOF
```

Done. Open any repo in Codex and the skills activate automatically based on your task.

---

## Option B — Single project install

Scoped to one repo. Good for team projects where you don't want to touch `~/.agents`.

```bash
cd /path/to/your-project

# 1. Install skills (pick the ones you want or use *)
mkdir -p .agents/skills
cp -r /path/to/codex-spellbook/skills/security    .agents/skills/
cp -r /path/to/codex-spellbook/skills/api-design  .agents/skills/
cp -r /path/to/codex-spellbook/skills/testing     .agents/skills/
# or all of them:
cp -r /path/to/codex-spellbook/skills/*           .agents/skills/

# 2. Add project-level instructions
# Pick the template closest to your stack:
#   python-api | typescript-api | go-service | fullstack-web | data-pipeline
cp /path/to/codex-spellbook/agents/python-api.agents.md AGENTS.md
# Then open AGENTS.md and adjust "## Environment Setup" for your project

# 3. Install hooks
mkdir -p .codex
cp /path/to/codex-spellbook/hooks/hooks.json .codex/hooks.json
cp -r /path/to/codex-spellbook/hooks/scripts .codex/

# 4. Enable the hooks feature (one-time per machine)
cat >> "$HOME/.codex/config.toml" << 'EOF'

[features]
codex_hooks = true
EOF
```

---

## Option C — Full team setup (commit to the repo)

Commit `.agents/skills/` and `.codex/hooks.json` so every team member gets the same setup automatically when they open the project in Codex.

```bash
cd /path/to/your-project

# 1. Add skills to the repo
mkdir -p .agents/skills
cp -r /path/to/codex-spellbook/skills/* .agents/skills/

# 2. Add AGENTS.md
cp /path/to/codex-spellbook/agents/typescript-api.agents.md AGENTS.md

# 3. Add hooks config
mkdir -p .codex
cp /path/to/codex-spellbook/hooks/hooks.json .codex/hooks.json
cp -r /path/to/codex-spellbook/hooks/scripts .codex/

# 4. Commit everything
git add .agents/ .codex/ AGENTS.md
git commit -m "chore: add codex-spellbook skills and hooks"
```

Each team member still needs `[features] codex_hooks = true` in their own `~/.codex/config.toml` to activate hooks — that's a machine setting, not a repo setting.

---

## Using task prompts

Task prompts are one-shot instructions you paste directly into Codex. No install needed.

1. Open a file from `task-prompts/`
2. Replace every `$UPPERCASE` placeholder with real values
3. Paste into Codex

```
# Example: run a PR review
Open task-prompts/review/pr-review.md, fill in $TARGET_BRANCH, then submit to Codex.
```

Available prompts:

| Category | Prompts |
| --- | --- |
| Review | `pr-review`, `security-audit` |
| Generate | `unit-tests`, `integration-tests`, `openapi-spec`, `migration` |
| Refactor | `extract-function`, `add-types` |
| Audit | `dependencies`, `find-secrets` |
| Document | `readme`, `adr` |
| Scaffold | `fastapi-service`, `express-api`, `go-http-service` |

---

## Using environment setup scripts

The scripts in `setup-scripts/` bootstrap a fresh Codex VM. Reference them from your `AGENTS.md`:

```markdown
## Environment Setup

Run before starting work:

```bash
bash setup-scripts/python.sh
```
```

Available: `python.sh`, `node.sh`, `go.sh`, `rust.sh`

---

## What hooks do

Once wired up, hooks run automatically during a Codex session:

| When | Script | Effect |
| --- | --- | --- |
| Before any `bash` command | `guard_force_push.sh` | Blocks `git push --force` (allows `--force-with-lease`) |
| Before any `bash` command | `warn_rm_rf.sh` | Prints a warning when `rm -rf` is attempted |
| At the end of each turn | `validate_spellbook.sh` | Runs skill/prompt/template validators (only in this repo) |

Format-on-save hooks (`format_markdown.sh`, `format_python.sh`, `format_web.sh`) are **not** wired as Codex hooks because Codex's hook system only intercepts Bash commands, not file edits. Run them manually or via `pre-commit`:

```bash
# Manual
bash hooks/scripts/format_python.sh src/app.py

# Or set up pre-commit (recommended)
pip install pre-commit && pre-commit install
```

---

## Verify the install

```bash
# Check skills are visible to Codex
ls "$HOME/.agents/skills"        # global
ls .agents/skills                 # project

# Check hooks config is valid JSON
python -c "import json; json.load(open('.codex/hooks.json')); print('OK')"

# Run the spellbook validators (from the codex-spellbook repo)
python scripts/validate_skills.py
python scripts/validate_task_prompts.py
python scripts/validate_agent_templates.py
```
