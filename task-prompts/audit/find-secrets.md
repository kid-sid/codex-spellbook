---
name: find-secrets
description: Scan a repository for hardcoded secrets, credentials, and token-shaped strings.
category: audit
---

Scan `$TARGET_PATHS` for hardcoded secrets.

Inspect source files, config, examples, shell scripts, CI files, and tests. Look for API keys, JWT secrets, cloud credentials, private URLs, and copied production tokens.

Output:

- `Confirmed Secrets`
- `Likely Secrets`
- `False Positives`
- `Remediation Steps`

Constraints:

- include file paths and the exact kind of secret exposed
- prefer environment-variable or secret-manager remediation
- distinguish sample placeholders from real credential material
