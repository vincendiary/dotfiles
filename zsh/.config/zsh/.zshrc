# ~/.config/zsh/.zshrc

## Path

typeset -U path PATH
path=(
	$HOME/.local/bin
	$HOME/.cargo/bin
	$HOME/.bun/bin
	$path
)

## Env

export HISTFILE=$ZDOTDIR/.zsh_history
export HISTSIZE=20000
export SAVEHIST=20000

## Options

setopt AUTO_CD              # cd by typing directory name
setopt AUTO_PUSHD           # pushd by typing directory name
setopt PUSHD_IGNORE_DUPS    # don't push dupes on pushd
setopt PUSHD_SILENT         # don't print pushd messages
setopt COMPLETE_IN_WORD     # complete from cursor position
setopt ALWAYS_TO_END        # move cursor to end of line after completion
setopt HIST_FIND_NO_DUPS    # skip dupes on search
setopt HIST_IGNORE_ALL_DUPS # don't save dupes
setopt HIST_IGNORE_SPACE    # space prefixed commands are not saved
setopt EXTENDED_HISTORY     # save timestamp and duration of commands
setopt SHARE_HISTORY        # share history between sessions
setopt INTERACTIVE_COMMENTS # allow comments in interactive mode

## Plugins & Completions

[[ -s $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] &&
	source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[[ -s $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
	source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -s $ZDOTDIR/plugins/sudo.plugin.zsh ]] &&
	source $ZDOTDIR/plugins/sudo.plugin.zsh

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive completion
fpath+=$ZDOTDIR/plugins/zsh-completions/src

autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
	compinit -d $ZDOTDIR/.zcompdump # regenerate if cache is older than 24h
else
	compinit -C -d $ZDOTDIR/.zcompdump # skip regeneration, use cache
fi

# gvm (interactive shells only — its chpwd hook errors in non-interactive shells)
[[ -s "$GVM_DIR/scripts/gvm" ]] && source "$GVM_DIR/scripts/gvm"

# nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# bun completions
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)" # sets up z, zi, and the tracking hook

## Theme

command -v oh-my-posh &>/dev/null &&
	eval "$(oh-my-posh init zsh --config $ZDOTDIR/themes/omp/hearthside.omp.yaml)"

## Aliases

alias reload="source $ZDOTDIR/.zshrc"
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias grb="git rebase"
alias gs="git status"
alias gl="git log --oneline"
alias ls="eza --icons=always"

## Functions

gfo() { git fetch origin $1:$1; }
killport() {
	local port=$(lsof -t -i:$1)
	if [[ -z $port ]]; then
		echo "nothing running on port $1"
	else
		kill $port
	fi
}
ghcl() { git clone git@github.com:$1.git $2; }
keep_current_path() {
	command -v wslpath &>/dev/null &&
		printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)

## Keybinds

bindkey '^[[1;5A' history-beginning-search-backward # ctrl+up = search matching history backward
bindkey '^[[1;5B' history-beginning-search-forward  # ctrl+down = search matching history forward
bindkey '^[[1;5D' backward-word                     # ctrl+left = skip words backward
bindkey '^[[1;5C' forward-word                      # ctrl+right = skip words forward
bindkey '^H' backward-kill-word                     # ctrl+backspace = delete the previous word

## Source OS-specific config

OS_FILE="$ZDOTDIR/$(uname -s).zsh"
[[ -s "$OS_FILE" ]] && source $OS_FILE

## Post-OS shared config

[[ -n "$PNPM_HOME" ]] && path=("$PNPM_HOME/bin" $path) # PNPM_HOME differs between OS

# sdkman
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"
