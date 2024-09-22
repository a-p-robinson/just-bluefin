# Choose bluefin version to rebase to.
rebase:
	#!/bin/bash
	echo 'Select the bluefin version you want from the menu:'
	ujust rebase-helper

# Rebase to devmode.
devmode:
	ujust devmode

# Set the hostname
hostname host:
	hostnamectl set-hostname {{host}}

# Options if we are on a NVIDIA laptop
nvidia-laptop:
	#!/bin/bash
	pushd ~/repos/ansible-silverblue
	ansible-playbook -K nvidia_bluefin.yml
	popd
	ujust configure-nvidia
	ujust configure-nvidia-optimus


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

# Apply "system" ansible roles.
ansible-system-pre-reboot:
	#!/bin/bash
	pushd ~/repos/ansible-silverblue
	ansible-playbook -K pre-reboot_base_system_home_bluefin.yml
	
# Apply "user" ansible roles.
ansible-user:
	#!/bin/bash
	pushd ~/repos/ansible-silverblue
	ansible-playbook -K user_apr_bluefin.yml
	popd

# Run user setup for bluefin
bluefin-user:
	ujust dx-group
	ujust toggle-user-motd
	ujust bluefin-cli
	brew bundle --file ~/Brewfile

# Run all the stuff that needs a reboot afterwards
first: devmode yadm get-ansible ansible-system-pre-reboot

# Setup my user account
user: ansible-user bluefin-user

# Then fix problems and setup apps
# - apply my gnome config?
# - firefox profile copy? (acceleration)
# https://docs.fedoraproject.org/en-US/quick-docs/configuring-xorg-as-default-gnome-session/

# - fio fixed yet?


# https://just.systems/man/en/
