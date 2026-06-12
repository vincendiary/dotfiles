# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this is

Personal dotfiles managed with **GNU Stow**. Each top-level directory is a stow
*package* whose contents mirror `$HOME`. Stowing a package symlinks its files
into the home directory:

```sh
stow zsh          # links zsh/.config/zsh/... -> ~/.config/zsh/...
stow -D zsh       # unlink (delete)
stow -R zsh       # restow (re-link after changes)
```

So a file's path inside a package literally encodes its destination: e.g.
`zsh/.config/zsh/.zshrc` lands at `~/.config/zsh/.zshrc`. When adding files,
place them at the `$HOME`-relative path under the package directory.

Packages: `agents`, `claude`, `codex`, `ghostty`, `git`, `neovim`, `zsh`.

There is no build, test, or lint step — changes take effect on next shell/app
launch (or after `stow -R`).

## Shared AI-agent config (the important architecture)

`agents/.agents` is a git **submodule** (`github.com:vincendiary/agents`) that
holds the single source of truth for AI tooling config: `AGENTS.md` plus
`agents/`, `commands/`, `hooks/`, `skills/`, `rules/`.

The `claude` and `codex` packages do **not** duplicate this — they are almost
entirely **symlinks pointing into `agents/.agents`**:

- `claude/.claude/{CLAUDE.md,agents,commands,hooks,skills}` → `../../agents/.agents/...`
- `codex/.codex/{AGENTS.md,agents,commands,hooks,skills}` → `../../agents/.agents/...`

Consequence: to change agent behaviour for both Claude Code and Codex, edit
files in `agents/.agents/` and commit there (it's a separate repo), then bump
the submodule pointer in this repo. Editing `claude/` or `codex/` directly only
makes sense for tool-specific files that are *not* symlinks (e.g.
`codex/.codex/RTK.md`, `claude/.config/ccstatusline/settings.json`).

## zsh loading model

`zsh/.zshenv` sets `ZDOTDIR="$HOME/.config/zsh"`, so the entire zsh config lives
under `~/.config/zsh`. `.zshrc` sources modular files **in a deliberate order**
(exports must come first, aliases last):

```
exports → options → plugins → completions → keybinds → functions → aliases
```

then platform overrides (`platform/macos.zsh` or `platform/linux.zsh` by
`uname -s`), then `~/.zshrc.local` (gitignored, machine-local). When adding
config, put it in the matching module — don't inline it into `.zshrc`.

Plugins (`zsh/.config/zsh/plugins/`) are git submodules:
`fast-syntax-highlighting`, `zsh-autosuggestions`, `zsh-completions`.

## Submodule wiring gotcha

Submodule plumbing encodes the path depth in **relative** paths, so moving a
stow package silently breaks it. When relocating a submodule, four things must
all be updated together or git will commit the worktree as plain files instead
of a gitlink:

1. `.gitmodules` — `path` and the `[submodule "<name>"]` section name
2. `.git/config` — the `submodule.<name>.*` section name
3. the gitdir location under `.git/modules/<name>` (must match the submodule name)
4. the worktree `.git` pointer file and `core.worktree` in the gitdir — the
   `../` depth must match how deep the worktree sits below the repo root

After fixing, `git submodule sync <path> && git submodule init <path>`, then
confirm `git submodule status` shows a leading space (clean) for every entry.

## Conventions

- `.editorconfig`: **tabs**, width 2, LF, final newline, trim trailing
  whitespace, max line length 100. Applies repo-wide including shell scripts.
- Commits are SSH-signed (`git/.gitconfig`: `commit.gpgsign = true`, `gpg.format
  = ssh`). `core.pager` / diff filter is `delta`; `core.editor = cursor`.
