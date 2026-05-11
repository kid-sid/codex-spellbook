# Tools

Utilities for installing pieces of this spellbook into another repository.

## `install.ps1`

Installs skills, hooks, and an `AGENTS.md` template into a target project (or globally).

### Project install

```powershell
pwsh tools/install.ps1 -Project -AllSkills -Hooks -AgentTemplate python-api -Target C:\path\to\repo
```

### Global install

```powershell
pwsh tools/install.ps1 -Global -AllSkills -Hooks
```

Notes:
- The installer does not overwrite existing files/directories.
- Hooks still require enabling in `~/.codex/config.toml`:
  ```toml
  [features]
  codex_hooks = true
  ```

