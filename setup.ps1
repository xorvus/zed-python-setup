$ErrorActionPreference = "Stop"

function Install-Tools {
    if (-not (Get-Command uv -ErrorAction SilentlyContinue)) {
        irm https://astral.sh/uv/install.ps1 | iex
    }
    uv tool install ruff --upgrade
}

function Configure-Zed {
    python configure_zed.py
}

function Main {
    Install-Tools
    Configure-Zed
}

Main
