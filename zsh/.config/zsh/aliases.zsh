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
alias reoption="source $ZDOTDIR/options.zsh"
alias reexport="source $ZDOTDIR/exports.zsh"
alias refunction="source $ZDOTDIR/functions.zsh"
alias rekeybind="source $ZDOTDIR/keybinds.zsh"
alias recompletion="source $ZDOTDIR/completions.zsh"
alias replugin="source $ZDOTDIR/plugins.zsh"

# Misc
alias ls="eza --icons=always"
alias code="cursor"
alias vi="nvim"
alias vim="nvim"
