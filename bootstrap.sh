#!/bin/bash 


function doIt() {
	rsync --exclude ".git/" \
		--exclude ".DS_Store" \
		--exclude "README.md" \
		--exclude "bootstrap.sh" \
		--exclude "brew.sh" \
    		-avh --no-perms . ~;
	source ~/.zshrc
}

function install() {
# Install Oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

./brew.sh
./.macos
}

read -p "This may overwrite some existing files in your home directory. Are you sure? (y/n)" -n 1;
echo "";

if [[ $REPLY =~ ^[Yy]$ ]]; then
	install
	doIt
fi

unset doIt;

