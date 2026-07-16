# ~/.config/zsh/aliases.zsh

# Nav
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ......="cd ../../../../.."

# Git
alias g="git"
alias ga="git add"
alias grm="git rm"
alias gc="git commit"
alias gco="git checkout"
alias gcof="git branch | fzf | xargs git checkout"
alias grb="git rebase"
alias gs="git status"
alias gl="git log --oneline --graph --decorate"
alias gf="git fetch"
alias pull="git pull"
alias push="git push"
alias pushf="git push --force-with-lease"

## Submodules
alias gsm="git submodule"
alias gsmpull="git submodule update --init --recursive"

# Reload
alias reload="source $ZDOTDIR/.zshrc"
alias realias="source $ZDOTDIR/aliases.zsh"
alias reoption="source $ZDOTDIR/options.zsh"
alias reexport="source $ZDOTDIR/exports.zsh"
alias refunction="source $ZDOTDIR/functions.zsh"
alias rekeybind="source $ZDOTDIR/keybinds.zsh"
alias recompletion="source $ZDOTDIR/completions.zsh"
alias replugin="source $ZDOTDIR/plugins.zsh"

# devcontainers
alias devreup="devcontainer up --remove-existing-container"
alias devsh="devcontainer exec zsh"

# claude code
alias ccw="claude -w"
alias ccn="claude -n"
alias ccresume="claude -r"
alias ccdsp="claude --dangerously-skip-permissions"

# Misc
alias ls="eza --icons=always"
alias code="cursor"
alias vi="nvim"
alias vim="nvim"
alias cl="clear"

