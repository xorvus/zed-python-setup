$ErrorActionPreference = "Stop"

function Install-Tools {
    if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
        irm https://astral.sh/uv/install.ps1 | iex
    }
    uv tool install ruff --upgrade
}

function Configure-Zed {
    if (Test-Path "configure_zed.py") {
        python configure_zed.py
    } else {
        $code = irm https://raw.githubusercontent.com/xorvus/zed-python-setup/main/configure_zed.py
        $code | python -
    }
}

function Main {
    Install-Tools
    Configure-Zed
}

Main
