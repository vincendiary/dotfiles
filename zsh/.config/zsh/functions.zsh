# ~/.config/zsh/functions.zsh

# Git
gcm() { git commit -m "$1"; }
gca() { git commit --amend; }
gfo() { git fetch origin $1:$1; }

# Github
ghcl() { git clone --recurse-submodules git@github.com:$1.git $2; }
ghsm_add() { git submodule add git@github.com:$1.git $2; }
ghre_add() { git remote add origin git@github.com:$1.git; }
ghre_set() { git remote set-url origin git@github.com:$1.git; }

# Ports
port() {
	if [[ -z $1 ]]; then
		echo "error: port number is required"
		return 1
	fi
	local port=$(lsof -t -i:$1)
	if [[ -z $port ]]; then
		return 1
	fi
	echo $port
}
killport() {
	if [[ -z $1 ]]; then
		echo "error: port number is required"
		return 1
	fi
	local port=($(port $1))
	if [[ -z $port ]]; then
		echo "nothing running on port $1"
		return 1
	fi
	kill $port
}

# Tickets
clipcopy() {
	if command -v clip.exe &>/dev/null; then
		print -rn -- "$1" | clip.exe
	elif command -v pbcopy &>/dev/null; then
		print -rn -- "$1" | pbcopy
	elif command -v xclip &>/dev/null; then
		print -rn -- "$1" | xclip -selection clipboard
	elif command -v wl-copy &>/dev/null; then
		print -rn -- "$1" | wl-copy
	else
		# OSC52: escape to host terminal clipboard (via tty so it never pollutes stdout capture)
		printf '\e]52;c;%s\a' "$(print -rn -- "$1" | base64 | tr -d '\n')" >/dev/tty
	fi
}
acmtccw() {
	local b
	b=$(acmtb "$1") || { print -r -- "$b"; return 1; }
	claude -w "$b"
}
acmtb() {
	if [[ -z $1 ]]; then
		echo "error: ticket number is required"
		return 1
	fi
	local tickets=$OAC_TICKETS
	if [[ ! -d $tickets ]]; then
		local d=$PWD
		while [[ $d != / ]]; do
			[[ -d $d/.vincendiary/tickets ]] && tickets=$d/.vincendiary/tickets && break
			d=${d:h}
		done
	fi
	if [[ ! -d $tickets ]]; then
		echo "error: .vincendiary/tickets not found (run inside oac dir or set OAC_TICKETS)"
		return 1
	fi
	local num=${1#acmt-}
	local dir=($tickets/acmt-${num}_*(N))
	if [[ -z $dir ]]; then
		echo "error: no ticket folder for acmt-$num"
		return 1
	fi
	local file
	for file in $dir/plan.md $dir/input.md; do
		[[ -f $file ]] || continue
		local branch=$(sed -n 's/^[Bb]ranch: *//p' $file | head -1 | tr -d '`')
		if [[ -n $branch ]]; then
			clipcopy "$branch"
			echo "$branch"
			return 0
		fi
	done
	echo "error: no branch found in $dir"
	return 1
}

# WSL
keep_current_path() {
	command -v wslpath &>/dev/null &&
		printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)
