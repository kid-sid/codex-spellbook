<#
.SYNOPSIS
  Run repository validation checks (Windows-friendly).

.DESCRIPTION
  Mirrors `make validate` but works on Windows machines without `make` or `python3` on PATH.
  Prefers the Codex bundled Python runtime when available.
#>

[CmdletBinding()]
param()

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Resolve-Python {
  $candidates = @(
    "python3",
    "python",
    "py",
    (Join-Path $HOME ".cache\\codex-runtimes\\codex-primary-runtime\\dependencies\\python\\python.exe")
  )
  foreach ($c in $candidates) {
    if ($c -match "\\.exe$" -and -not (Test-Path -LiteralPath $c)) {
      continue
    }
    if ($c -notmatch "\\.exe$" -and -not (Get-Command $c -ErrorAction SilentlyContinue)) {
      continue
    }
    try {
      & $c -c "import sys; print(sys.executable)" 2>$null | Out-Null
      if ($LASTEXITCODE -eq 0) { return $c }
    } catch {
      continue
    }
  }
  throw "No Python found. Install Python or use Codex bundled runtime."
}

$py = Resolve-Python
Write-Host "Python: $py"

function Run([string[]]$Args) {
  & $py @Args
  if ($LASTEXITCODE -ne 0) {
    throw "Command failed (exit $LASTEXITCODE): $py $($Args -join ' ')"
  }
}

Run @("scripts/validate_skills.py")
Run @("scripts/validate_task_prompts.py")
Run @("scripts/validate_agent_templates.py")

Write-Host "OK"
