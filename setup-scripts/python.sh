#!/usr/bin/env bash
set -euo pipefail

export PYENV_ROOT="${PYENV_ROOT:-$HOME/.pyenv}"
if [ ! -d "$PYENV_ROOT" ]; then
  git clone https://github.com/pyenv/pyenv.git "$PYENV_ROOT"
fi

export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

pyenv install -s 3.12.3
pyenv global 3.12.3

python -m pip install --upgrade pip
python -m pip install --upgrade uv poetry ruff mypy pytest pytest-asyncio httpx
