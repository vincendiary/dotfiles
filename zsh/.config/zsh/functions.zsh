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

# WSL
keep_current_path() {
	command -v wslpath &>/dev/null &&
		printf "\e]9;9;%s\e\\" "$(wslpath -w "$PWD")"
}
precmd_functions+=(keep_current_path)
