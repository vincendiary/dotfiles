# ~/.config/zsh/platform/linux.zsh

# env
export PNPM_HOME="$HOME/.local/share/pnpm"
# path
typeset -U path PATH
path+=($PNPM_HOME/bin)
export PATH

# linuxbrew
[ -x /home/linuxbrew/.linuxbrew/bin/brew ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv zsh)"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)"
