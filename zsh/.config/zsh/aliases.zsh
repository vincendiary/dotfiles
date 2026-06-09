# ~/.config/zsh/aliases.zsh

# Nav
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Git
alias ga="git add"
alias gc="git commit"
alias gco="git checkout"
alias grb="git rebase"
alias gs="git status"
alias gl="git log --oneline --graph --decorate"
alias gf="git fetch"
alias gp="git pull"
alias push="git push"
alias gsubpull="git submodule update --init --recursive"

# Reload
alias reload="source $ZDOTDIR/.zshrc"
alias realias="source $ZDOTDIR/aliases.zsh"
alias reoptions="source $ZDOTDIR/options.zsh"
alias reexports="source $ZDOTDIR/exports.zsh"
alias refunctions="source $ZDOTDIR/functions.zsh"
alias rekeybinds="source $ZDOTDIR/keybinds.zsh"
alias recompletions="source $ZDOTDIR/completions.zsh"
alias replugins="source $ZDOTDIR/plugins.zsh"

# Misc
alias ls="eza --icons=always"
alias code="cursor"
alias vi="nvim"
alias vim="nvim"
