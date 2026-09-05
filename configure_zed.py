import json
import os
import re
import shutil

def get_settings_path() -> str:
    if os.name == "nt":
        base = os.environ.get("APPDATA") or os.path.expanduser("~\\AppData\\Roaming")
        return os.path.join(base, "Zed", "settings.json")
    return os.path.expanduser("~/.config/zed/settings.json")

def load_settings(path: str) -> dict:
    if not os.path.exists(path):
        return {}
    with open(path, "r", encoding="utf-8") as f:
        clean = re.sub(r"//.*", "", f.read())
        return json.loads(clean) if clean.strip() else {}

def build_python_config() -> dict:
    return {
        "language_servers": ["ty", "ruff", "!basedpyright"],
        "format_on_save": "on",
        "formatter": {"language_server": {"name": "ruff"}},
        "code_actions_on_format": {
            "source.fixAll.ruff": True,
            "source.organizeImports.ruff": True,
        },
    }

def apply_config(data: dict) -> dict:
    data.setdefault("autosave", "on_focus_change")
    languages = data.setdefault("languages", {})
    languages["Python"] = build_python_config()
    return data

def backup_settings(path: str) -> None:
    if os.path.exists(path):
        shutil.copy2(path, f"{path}.bak")

def save_settings(path: str, data: dict) -> None:
    os.makedirs(os.path.dirname(path), exist_ok=True)
    with open(path, "w", encoding="utf-8") as f:
        json.dump(data, f, indent=2)

def main() -> None:
    path = get_settings_path()
    settings = load_settings(path)
    backup_settings(path)
    updated = apply_config(settings)
    save_settings(path, updated)

if __name__ == "__main__":
    main()
