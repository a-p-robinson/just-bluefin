# Set the hostname
hostname host:
	hostnamectl set-hostname {{host}}

# Rebase to devmode.
devmode:
	ujust devmode
	reboot

# First update
first-update:
    ujust update
    brew update

# Run user setup for bluefin
bluefin-user:
	ujust dx-group
	ujust toggle-user-motd
	ujust bluefin-cli
	brew bundle --file /usr/share/ublue-os/homebrew/system-dx-flatpaks.Brewfile
	brew bundle --file /usr/share/ublue-os/homebrew/fonts.Brewfile

# User apps through brew
user-apps:
	brew bundle
	#!/bin/bash
	source /home/apr/SCRIPTS/Joplin_install_and_update.sh
	
	# Can do joplin appimage if I have yadm....
	# Fiji
	# dia
	# emacs
	# headsetcontrol

# Install my dotfiles.
yadm:
	#!/bin/bash
	brew install yadm
	pushd ~/
	yadm clone --no-bootstrap -b ver4 -f https://github.com/a-p-robinson/yadm
	yadm -C ~ submodule update --init --recursive
	yadm bootstrap
	gpgconf --reload gpg-agent
	yadm decrypt
	popd

# Install ansible and get my configuration repo.
get-ansible:
	brew install ansible
	#!/bin/bash
	if [ ! -d ~/repos ]; then mkdir ~/repos; fi
	git clone -b bluefin git@github.com:a-p-robinson/ansible-silverblue.git ~/repos/ansible-silverblue

# Quick setup your app configs by copying from another system
quick-set-apps target:
	#!/bin/bash
	read -p "Make sure the applications are not running on target machine (continue: y/n?) " -n 1 -r
	echo  
	if [[ $REPLY =~ ^[Yy]$ ]]
	then
	echo "I will get your stuff from {{target}}:"
	
	echo "**Firefox**"
	read -p "Using the firefox snap? (y/n) " -n 1 -r SNAP
	echo  
	
	if [[ $SNAP =~ ^[Yy]$ ]]
	then
	echo "  **SNAP**"
		mv ~/snap/firefox/common/.mozilla ~/snap/firefox/common/.mozilla-local
		scp -r $USER@{{target}}:.mozilla ~/snap/firefox/common/.mozilla/
	else
		mv ~/.mozilla ~/.mozilla-local
		scp -r $USER@{{target}}:.mozilla ~/
	fi

	echo "**Joplin**"
	mv ~/.config/Joplin ~/.config/Joplin-local
	mv ~/.config/joplin-desktop ~/.config/joplin-desktop-local
	scp -r $USER@{{target}}:.config/Joplin ~/.config/
	scp -r $USER@{{target}}:.config/joplin-desktop ~/.config/
	
	echo "**Zotero**"
	mv ~/.zotero ~/.zotero-local
	mv ~/Zotero ~/Zotero-local
	scp -r $USER@{{target}}:.zotero ~/
	scp -r $USER@{{target}}:Zotero ~/

	fi



# Run all the stuff that needs a reboot afterwards
#first: devmode yadm get-ansible ansible-system-pre-reboot

# Setup my user account
#user: ansible-user bluefin-user

# Then fix problems and setup apps
# - apply my gnome config?
# - firefox profile copy? (acceleration)

# - fio fixed yet?


# https://just.systems/man/en/
