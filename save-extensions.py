#!/usr/bin/env python3

import shutil
import subprocess
import sys
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent


def main():
    print("💾 Saving Cursor Extension Lists...")

    save_editor("cursor", "win-cursor/.cursor/extensions/list.txt")

    print("✅ Extension lists saved!")


def save_editor(command, list_file):
    print(f"📋 {command.upper()}:")
    list_file_path = SCRIPT_DIR / list_file
    command_path = shutil.which(command)

    if command_path is None:
        print(f"   ⚠️  Missing {command} CLI. Skipping extension save.")
        return

    installed_extensions = get_installed_extensions(command_path)
    write_list(list_file_path, installed_extensions)


def get_installed_extensions(command_path):
    result = subprocess.run(
        [command_path, "--list-extensions"],
        capture_output=True,
        text=True,
        check=True,
    )
    extensions = [line for line in result.stdout.strip().split("\n") if line]
    return sorted(extensions)


def write_list(list_file_path, extensions):
    list_file_path.parent.mkdir(parents=True, exist_ok=True)
    list_file_path.write_text("\n".join(extensions) + "\n")

    rel = list_file_path.relative_to(SCRIPT_DIR)
    print(f"   ✅ List updated: {len(extensions)} extensions written to {rel}")


if __name__ == "__main__":
    main()
