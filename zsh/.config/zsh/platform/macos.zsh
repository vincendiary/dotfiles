# ~/.config/zsh/platform/macos.zsh

# env
export PNPM_HOME="$HOME/Library/pnpm"

# path
typeset -U path PATH
path+=($PNPM_HOME/bin)
export PATH

# Homebrew
eval "$(/opt/homebrew/bin/brew shellenv)"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
