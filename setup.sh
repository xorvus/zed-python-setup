#!/usr/bin/env bash
set -e

install_tools() {
  command -v uv >/dev/null 2>&1 || curl -LsSf https://astral.sh/uv/install.sh | sh
  uv tool install ruff --upgrade
}

configure_zed() {
  if [ -f "configure_zed.py" ]; then
    python3 configure_zed.py
  else
    curl -fsSL "https://raw.githubusercontent.com/xorvus/zed-python-setup/main/configure_zed.py" | python3
  fi
}

main() {
  install_tools
  configure_zed
}

main "$@"
