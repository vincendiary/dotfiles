# ~/.config/zsh/functions.zsh

# Git
gca() { git commit --amend; }
gfo() { git fetch origin $1:$1; }

# Github
ghcl() { git clone --recurse-submodules git@github.com:$1.git $2; }
ghsubadd() { git submodule add git@github.com:$1.git $2; }
ghremadd() { git remote add origin git@github.com:$1.git; }
ghremset() { git remote set-url origin git@github.com:$1.git; }

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
fzfc() {
	clipcopy "$(fzf)"
}

# WSL
keep_current_path() {
	command -v wslpath &>/dev/null &&
		printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)
