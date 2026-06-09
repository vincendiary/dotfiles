# ~/.config/zsh/completions.zsh

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' # case-insensitive completion
fpath+=$ZDOTDIR/plugins/zsh-completions/src

autoload -Uz compinit
if [[ -n $ZDOTDIR/.zcompdump(#qN.mh+24) ]]; then
	compinit -d $ZDOTDIR/.zcompdump # regenerate if cache is older than 24h
else
	compinit -C -d $ZDOTDIR/.zcompdump # skip regeneration, use cache
fi
