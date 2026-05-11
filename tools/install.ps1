<#
.SYNOPSIS
  Install codex-spellbook assets into a project or globally.

.DESCRIPTION
  - Skills -> .agents/skills (project) or $HOME/.agents/skills (global)
  - Hooks  -> .codex (project) or $HOME/.codex (global)
  - AGENTS.md template -> project root

  This script is intentionally conservative: it does not overwrite existing files/directories.

.EXAMPLE
  pwsh tools/install.ps1 -Project -AllSkills -Hooks -AgentTemplate python-api

.EXAMPLE
  pwsh tools/install.ps1 -Global -AllSkills -Hooks
#>

[CmdletBinding()]
param(
  [Parameter(Mandatory = $false)]
  [string]$Target = (Get-Location).Path,

  [Parameter(Mandatory = $false, ParameterSetName = "Project")]
  [switch]$Project,

  [Parameter(Mandatory = $false, ParameterSetName = "Global")]
  [switch]$Global,

  [Parameter(Mandatory = $false)]
  [switch]$Hooks,

  [Parameter(Mandatory = $false)]
  [switch]$AllSkills,

  [Parameter(Mandatory = $false)]
  [string[]]$Skills = @(),

  [Parameter(Mandatory = $false)]
  [ValidateSet("python-api", "typescript-api", "go-service", "fullstack-web", "data-pipeline")]
  [string]$AgentTemplate
)

Set-StrictMode -Version Latest
$ErrorActionPreference = "Stop"

function Ensure-Dir([string]$Path) {
  if (-not (Test-Path -LiteralPath $Path)) {
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
  }
}

$repoRoot = (Resolve-Path (Join-Path $PSScriptRoot "..")).Path
$skillsRoot = Join-Path $repoRoot "skills"
$hooksRoot = Join-Path $repoRoot "hooks"
$agentsRoot = Join-Path $repoRoot "agents"

if (-not $Project -and -not $Global) {
  $Project = $true
}

if ($Global) {
  $Target = $HOME
}

$targetRoot = (Resolve-Path $Target).Path

Write-Host "Installing from: $repoRoot"
Write-Host "Target:          $targetRoot"
Write-Host ""

if ($AllSkills -and $Skills.Count -gt 0) {
  throw "Use either -AllSkills or -Skills, not both."
}

if (-not $AllSkills -and $Skills.Count -eq 0 -and -not $Hooks -and -not $AgentTemplate) {
  throw "Nothing to install. Specify -AllSkills and/or -Skills and/or -Hooks and/or -AgentTemplate."
}

if ($AllSkills -or $Skills.Count -gt 0) {
  $skillsDest = if ($Global) { Join-Path $targetRoot ".agents\\skills" } else { Join-Path $targetRoot ".agents\\skills" }
  Ensure-Dir $skillsDest

  $toInstall = @()
  if ($AllSkills) {
    $toInstall = Get-ChildItem -Directory -LiteralPath $skillsRoot | Select-Object -ExpandProperty Name
  } else {
    $toInstall = $Skills
  }

  Write-Host "[Skills]"
  foreach ($name in ($toInstall | Sort-Object -Unique)) {
    $src = Join-Path $skillsRoot $name
    if (-not (Test-Path -LiteralPath $src)) {
      Write-Warning "Skip: unknown skill '$name' (not found at $src)"
      continue
    }
    $dst = Join-Path $skillsDest $name
    if (Test-Path -LiteralPath $dst) {
      Write-Warning "Skip: already exists: $dst"
      continue
    }
    Copy-Item -Recurse -Force -LiteralPath $src -Destination $dst
    Write-Host "[OK] $(Split-Path -Leaf $dst)"
  }
  Write-Host ""
}

if ($Hooks) {
  $codexDest = if ($Global) { Join-Path $targetRoot ".codex" } else { Join-Path $targetRoot ".codex" }
  Ensure-Dir $codexDest

  Write-Host "[Hooks]"
  $hooksJsonSrc = Join-Path $hooksRoot "hooks.json"
  $hooksJsonDst = Join-Path $codexDest "hooks.json"
  if (Test-Path -LiteralPath $hooksJsonDst) {
    Write-Warning "Skip: already exists: $hooksJsonDst"
  } else {
    Copy-Item -Force -LiteralPath $hooksJsonSrc -Destination $hooksJsonDst
    Write-Host "[OK] hooks.json"
  }

  $scriptsSrc = Join-Path $hooksRoot "scripts"
  $scriptsDst = Join-Path $codexDest "scripts"
  if (Test-Path -LiteralPath $scriptsDst) {
    Write-Warning "Skip: already exists: $scriptsDst"
  } else {
    Copy-Item -Recurse -Force -LiteralPath $scriptsSrc -Destination $scriptsDst
    Write-Host "[OK] scripts/"
  }
  Write-Host ""
  Write-Host "Note: enable hooks in $HOME\\.codex\\config.toml:"
  Write-Host "  [features]"
  Write-Host "  codex_hooks = true"
  Write-Host ""
}

if ($AgentTemplate) {
  Write-Host "[AGENTS.md]"
  $src = Join-Path $agentsRoot ($AgentTemplate + ".agents.md")
  $dst = Join-Path $targetRoot "AGENTS.md"
  if (-not (Test-Path -LiteralPath $src)) {
    throw "Agent template not found: $src"
  }
  if (Test-Path -LiteralPath $dst) {
    Write-Warning "Skip: already exists: $dst"
  } else {
    Copy-Item -Force -LiteralPath $src -Destination $dst
    Write-Host "[OK] AGENTS.md"
  }
  Write-Host ""
}

Write-Host "Done."
