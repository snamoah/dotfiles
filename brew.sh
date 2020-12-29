#!/bin/bash

sudo -v

if hash brew 2>/dev/null; then
	brew update
	brew upgrade
else
	CI=1 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install)"
fi

# Check and assign user to brew group
GROUP=brew

# create the group if it doesn't exist
if dseditgroup -o read $GROUP; then
	echo  "$GROUP exists. Skipping..."
else
	IFS=':' read -r -a list <<< "$(tail -n 1 /etc/group)"
	gid=$((list[2] + 1))
	dseditgroup -o create -n /Local/Default -r "Homebrew" -a $GROUP -p "*" -i $gid $GROUP
fi

if id -nG "$USER" | grep -qw $GROUP; then
    	echo $USER already belongs to $GROUP
else
	dseditgroup -o edit -a $GROUP -t user $USER
fi

# Change the group of homebrew installation directory
chgrp -R $GROUP $(brew --prefix)/*

# Allow all group members to write to homebrew directory
chmod -R g+w $(brew --prefix)/*

# brew install tools
for tool in 'tree' \
	'git' \
	'git-flow' \
	'gnupg' \
	'openssh' \
	'findutils'; do

	if hash $tool 2>/dev/null; then
		echo "$tool already installed. Skipping..."
	else
		brew install $tool
	fi
done

# brew cast install 
for app in 'toptracker' \
	'docker' \
	'visual-studio-code' \
	'zoomus' \
	'spotify'; do

	if hash $app 2>/dev/null; then
		echo "$app already installed. Skipping..."
	else
		brew install --cask $app
	fi
done

# clean up
brew cleanup
