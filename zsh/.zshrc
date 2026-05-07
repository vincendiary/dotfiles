### EXPORTS & OPTIONS

export ZSH=$HOME/.zsh
export DOTFILES=$HOME/projects/dotfiles

# zsh history
export HISTFILE=$ZSH/.zsh_history
export HISTSIZE=20000			# size of history file
export SAVEHIST=20000			# how many lines to save
setopt HIST_IGNORE_ALL_DUPS		# history won't save duplicates
setopt HIST_FIND_NO_DUPS		# history won't show duplicates on search

### PLUGINS & COMPLETIONS

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source $ZSH/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
source $ZSH/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fpath=($ZSH/plugins/zsh-completions/src $fpath)

### THEME

eval "$(oh-my-posh init zsh --config $DOTFILES/oh-my-posh/theme.omp.json)"

### ALIASES

alias ls="ls -G"

# git
alias ga="git add"
alias gb="git branch"
alias gc="git commit"
alias gco="git checkout"
alias gl="git log"
alias gp="git pull"
alias gr="git rebase"
alias gs="git status"
