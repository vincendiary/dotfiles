# ~/.config/zsh/keybinds.zsh

bindkey '^[[1;5A' history-beginning-search-backward # ctrl+up = search matching history backward
bindkey '^[[1;5B' history-beginning-search-forward  # ctrl+down = search matching history forward
bindkey '^[[1;5D' backward-word                     # ctrl+left = skip words backward
bindkey '^[[1;5C' forward-word                      # ctrl+right = skip words forward
bindkey '^H' backward-kill-word                     # ctrl+backspace = delete the previous word
