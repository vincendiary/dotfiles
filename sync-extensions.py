#!/usr/bin/env python3

import shutil
import subprocess
from pathlib import Path

SCRIPT_DIR = Path(__file__).resolve().parent


def main():
    print("📥 Installing Cursor Extensions from List...")

    install_editor("cursor", "win-cursor/.cursor/extensions/list.txt")

    print("✅ Extension installation complete!")


def install_editor(command, list_file):
    print(f"📋 {command.upper()}:")
    list_file_path = SCRIPT_DIR / list_file
    command_path = shutil.which(command)

    if not list_file_path.exists():
        print("   ⚠️  Extensions list not found. Skipping extensions install.")
        return

    if command_path is None:
        print(f"   ⚠️  Missing {command} CLI. Skipping extension install.")
        return

    pull_from_extensions_list(command_path, list_file_path)


def pull_from_extensions_list(command_path, list_file_path):
    desired_extensions = set(read_list(list_file_path))
    installed_extensions = set(get_installed_extensions(command_path))

    to_install = sorted(desired_extensions - installed_extensions)
    to_uninstall = sorted(installed_extensions - desired_extensions)

    install_extensions(command_path, to_install)
    uninstall_extensions(command_path, to_uninstall)

    if to_install or to_uninstall:
        print(
            f"   ✅ Sync complete: {len(to_install)} installed, "
            f"{len(to_uninstall)} uninstalled"
        )
    else:
        print(f"   ✅ Already in sync: {len(installed_extensions)} extensions")


def get_installed_extensions(command_path):
    result = subprocess.run(
        [command_path, "--list-extensions"],
        capture_output=True,
        text=True,
        check=True,
    )
    extensions = [line for line in result.stdout.strip().split("\n") if line]
    return sorted(extensions)


def install_extensions(command_path, extensions):
    if not extensions:
        return
    args = [command_path]
    for ext in extensions:
        args += ["--install-extension", ext]
    subprocess.run(args, check=True)


def uninstall_extensions(command_path, extensions):
    if not extensions:
        return
    args = [command_path]
    for ext in extensions:
        args += ["--uninstall-extension", ext]
    subprocess.run(args, check=True)


def read_list(list_file_path):
    text = list_file_path.read_text(encoding="utf-8")
    return [line for line in text.strip().split("\n") if line]


if __name__ == "__main__":
    main()
