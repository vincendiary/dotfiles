# dotfiles

Personal shell configuration for PowerShell and zsh, plus a shared Oh My Posh theme.

## Contents

```text
pwsh/
  Install.ps1    PowerShell bootstrap script
  Profile.ps1    PowerShell profile loaded by $PROFILE

themes/
  catppuccino.omp.json

zsh/
  init.sh        zsh bootstrap script
  .zshrc         zsh configuration
```

## PowerShell

Run the installer from the repository root:

```powershell
.\pwsh\Install.ps1
```

The installer is idempotent. It checks whether each dependency is already installed before running the install command.

It installs:

- `Terminal-Icons`
- `posh-git`
- `PSReadLine`
- `JanDeDobbeleer.OhMyPosh` via `winget`

It also creates or updates `$PROFILE` so PowerShell loads this repo's profile:

```powershell
. "C:\Path\To\dotfiles\pwsh\Profile.ps1"
```

The PowerShell profile derives the Oh My Posh theme path from its own location, so no manual theme environment variable is required.

## zsh

Run the zsh bootstrap script:

```bash
./zsh/init.sh
```

The script:

- Backs up an existing `~/.zshrc` to `~/.zshrc_backup`
- Creates `~/.zsh`
- Copies `zsh/.zshrc` into `~/.zsh/.zshrc`
- Symlinks `~/.zshrc` to `~/.zsh/.zshrc`
- Clones zsh plugins into `~/.zsh/plugins`

The zsh config expects this repository at:

```bash
$HOME/projects/dotfiles
```

## Theme

Both shells use:

```text
themes/catppuccino.omp.json
```

PowerShell resolves this relative to `pwsh/Profile.ps1`. zsh uses the `DOTFILES` variable set in `zsh/.zshrc`.
