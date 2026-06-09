# ~/.config/zsh/.zshrc

# Order matters: exports first, aliases last
local files=(
	exports
	options
	plugins
	completions
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

# Local overrides
[[ -f "$HOME/.zshrc.local" ]] && source "$HOME/.zshrc.local"

return 0
