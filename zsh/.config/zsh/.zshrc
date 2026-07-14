# ~/.config/zsh/.zshrc

export ZDOTDIR="$HOME/.config/zsh"

# Order matters: exports first, aliases last
local files=(
	exports
	options
	completions
	plugins
	keybinds
	functions
	aliases
)

for f in "${files[@]}"; do
	[[ -f "$ZDOTDIR/$f.zsh" ]] && source "$ZDOTDIR/$f.zsh"
done

# Platform-specific
case "$(uname -s)" in
Darwin) [[ -f "$ZDOTDIR/platform/macos.zsh" ]] && source "$ZDOTDIR/platform/macos.zsh" ;;
Linux) [[ -f "$ZDOTDIR/platform/linux.zsh" ]] && source "$ZDOTDIR/platform/linux.zsh" ;;
esac

# ssh
if [ -z "$SSH_AUTH_SOCK" ]; then
	eval "$(ssh-agent -s)" > /dev/null
	ssh-add ~/.ssh/id_ed25519 2>/dev/null
fi


# Local overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

return 0
