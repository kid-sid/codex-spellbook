<#
.SYNOPSIS
  Run markdown lint checks (Windows-friendly).
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

& $py "scripts/lint_markdown.py"
if ($LASTEXITCODE -ne 0) {
  throw "Command failed (exit $LASTEXITCODE): $py scripts/lint_markdown.py"
}
Write-Host "OK"
