# Just commands to configure a new bluefin system

- `just -f bluefin2.0.just hostname HOST`
  - Set the hostname = HOST

- `just -f bluefin2.0.just rebase`
  - First rebase if you want to change channel
  - **`reboot` when finished**

- `just -f bluefin2.0.just first`
  - Run all the recipes that need a reboot
  - Will setup dotfiles and pull in ansible repo
  - **`reboot` when finished**

- `just -f bluefin2.0.just user`
  - Setup user ansible roles
  - Setup user options from `ujust`
  - Install brew bundle

- `just -f bluefin2.0.just nvidia-laptop`
  - If you are using an nvidia laptop GPU
  - **`reboot` when finished**

