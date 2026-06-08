#!/bin/bash

ZSH=$HOME/.zsh
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

echo "Creating .zshrc backup..."
if [[ -f $HOME/.zshrc ]]; then
	mv $HOME/.zshrc $HOME/.zshrc_backup
fi
echo "Backup created at ~/.zshrc_backup"

echo "Creating zsh directories and files..."
mkdir -p $ZSH/plugins
touch $ZSH/.zsh_history
ln -s $SCRIPT_DIR/zshrc $HOME/.zshrc
echo "Directories and files created in ~/.zsh/"

echo "Cloning plugins..."
git clone git@github.com:zdharma-zmirror/fast-syntax-highlighting.git $ZSH/plugins/fast-syntax-highlighting
git clone git@github.com:zsh-users/zsh-autosuggestions.git $ZSH/plugins/zsh-autosuggestions
git clone git@github.com:zsh-users/zsh-completions.git $ZSH/plugins/zsh-completions
echo "Plugins setup in ~/.zsh/plugins/"

echo "Success! Reload the terminal using `source ~/.zshrc` to load new shell"
