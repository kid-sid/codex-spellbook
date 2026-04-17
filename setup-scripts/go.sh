#!/usr/bin/env bash
set -euo pipefail

GO_VERSION="${GO_VERSION:-1.22.3}"
GO_TARBALL="go${GO_VERSION}.linux-amd64.tar.gz"

curl -fsSLO "https://go.dev/dl/${GO_TARBALL}"
sudo rm -rf /usr/local/go
sudo tar -C /usr/local -xzf "$GO_TARBALL"
rm -f "$GO_TARBALL"

export PATH="/usr/local/go/bin:$HOME/go/bin:$PATH"

go install github.com/golangci/golangci-lint/cmd/golangci-lint@latest
go install golang.org/x/vuln/cmd/govulncheck@latest
