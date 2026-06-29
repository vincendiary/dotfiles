# ~/.config/zsh/exports.zsh

# Path
typeset -U path PATH
path=(
	$HOME/.local/bin
	$HOME/.cargo/bin
	$HOME/.bun/bin
	$path
)
export PATH

# Env
export EDITOR=nvim
export SUDO_EDITOR=nvim
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export BUN_INSTALL="$HOME/.bun"
export NVM_DIR="$XDG_CONFIG_HOME/nvm"
export SDKMAN_DIR="$HOME/.sdkman"
export GVM_DIR="$HOME/.gvm"
