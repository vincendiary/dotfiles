# ~/.config/zsh/plugins.zsh

# zsh plugins
[[ -s $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh ]] &&
	source $ZDOTDIR/plugins/fast-syntax-highlighting/fast-syntax-highlighting.plugin.zsh
[[ -s $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh ]] &&
	source $ZDOTDIR/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
[[ -s $ZDOTDIR/plugins/sudo.plugin.zsh ]] &&
	source $ZDOTDIR/plugins/sudo.plugin.zsh

# gvm
[[ -s "$GVM_DIR/scripts/gvm" ]] && source "$GVM_DIR/scripts/gvm"

# nvm
[[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh"
[[ -s "$NVM_DIR/bash_completion" ]] && source "$NVM_DIR/bash_completion"

# bun
[[ -s "$BUN_INSTALL/_bun" ]] && source "$BUN_INSTALL/_bun"

# sdkman
[[ -s "$SDKMAN_DIR/bin/sdkman-init.sh" ]] && source "$SDKMAN_DIR/bin/sdkman-init.sh"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init zsh)" # sets up z, zi, and the tracking hook

# oh-my-posh
command -v oh-my-posh &>/dev/null &&
	eval "$(oh-my-posh init zsh --config $ZDOTDIR/themes/omp/hearthside.omp.yaml)"
