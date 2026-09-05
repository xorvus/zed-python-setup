#!/usr/bin/env bash
set -e

install_tools() {
  command -v uv >/dev/null 2>&1 || curl -LsSf https://astral.sh/uv/install.sh | sh
  uv tool install ruff --upgrade
}

configure_zed() {
  python3 configure_zed.py
}

main() {
  install_tools
  configure_zed
}

main "$@"
