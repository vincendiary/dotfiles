# ~/.config/zsh/plugins.zsh

# zsh plugins
[[ -s $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] &&
	source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[[ -s $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
	source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -s $ZDOTDIR/plugins/sudo.plugin.zsh ]] &&
	source $ZDOTDIR/plugins/sudo.plugin.zsh

# nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# bun
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# oh-my-posh
command -v oh-my-posh &>/dev/null &&
	eval "$(oh-my-posh init zsh --config $HOME/.config/oh-my-posh/themes/hearthside.omp.yaml)"
