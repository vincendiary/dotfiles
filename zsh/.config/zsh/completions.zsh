# ~/.config/zsh/completions.zsh

# global substring and case-insensitive matching
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
# ignore remote branches on first tab
zstyle ':completion:*:*:git-checkout:*' tag-order 'heads-local' 'heads-remote' '*'

fpath+=$ZDOTDIR/plugins/zsh-completions/src

autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
	compinit -d $ZDOTDIR/.zcompdump # regenerate if cache is older than 24h
else
	compinit -C -d $ZDOTDIR/.zcompdump # skip regeneration, use cache
fi
