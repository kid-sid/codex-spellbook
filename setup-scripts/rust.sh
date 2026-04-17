#!/usr/bin/env bash
set -euo pipefail

if ! command -v rustup >/dev/null 2>&1; then
  curl https://sh.rustup.rs -sSf | sh -s -- -y
fi

export PATH="$HOME/.cargo/bin:$PATH"

rustup toolchain install stable
rustup default stable
rustup component add clippy
cargo install cargo-audit || true
