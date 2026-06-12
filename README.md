# dotfiles

Personal dotfiles for zsh, Neovim, Ghostty, git, and AI coding tools
(Claude Code / Codex), managed with [GNU Stow](https://www.gnu.org/software/stow/).

Each top-level directory is a stow *package* whose contents mirror `$HOME`.
Stowing a package symlinks its files into the home directory.

## Packages

| Package  | Links into                | Contents                                            |
| -------- | ------------------------- | --------------------------------------------------- |
| `zsh`    | `~/.zshenv`, `~/.config/zsh` | Modular zsh config + plugins (submodules)         |
| `neovim` | `~/.config/nvim`          | Neovim (kickstart-based) config                     |
| `ghostty`| `~/.config/ghostty`       | Ghostty terminal config                             |
| `git`    | `~/.gitconfig`            | Git config (delta pager, SSH-signed commits)        |
| `agents` | `~/.agents`               | Shared AI-agent config (submodule, source of truth) |
| `claude` | `~/.claude`, `~/.config`  | Claude Code config — mostly symlinks into `agents`  |
| `codex`  | `~/.codex`                | Codex config — mostly symlinks into `agents`        |

`claude` and `codex` don't duplicate agent config; they symlink into
`agents/.agents`, so `AGENTS.md`, commands, hooks, and skills are defined once
and shared across both tools.

## Prerequisites

- `git`, `stow`
- `zsh` (with `ZDOTDIR` honoured — set by `zsh/.zshenv`)
- Optional, auto-detected at shell startup if present: `zoxide`, `oh-my-posh`,
  `delta`, `nvm`, `bun`, `sdkman`, `gvm`

## Install

```sh
git clone --recurse-submodules git@github.com:vincendiary/dotfiles.git ~/dotfiles
cd ~/dotfiles

# stow the packages you want
stow zsh neovim ghostty git agents claude codex
```

If you cloned without `--recurse-submodules`:

```sh
git submodule update --init --recursive
```

Re-link after pulling changes:

```sh
stow -R <package>     # restow
stow -D <package>     # unlink
```

## Machine-local overrides

`~/.zshrc.local` is sourced last by zsh and is gitignored — put host-specific
settings (secrets, paths, per-machine tweaks) there rather than editing tracked
files.

## Layout notes

- **zsh** loads modular files in order — `exports → options → plugins →
  completions → keybinds → functions → aliases` — then a platform file
  (`platform/macos.zsh` / `platform/linux.zsh`), then `~/.zshrc.local`.
- See [CLAUDE.md](CLAUDE.md) for the full architecture and the submodule-wiring
  notes.
