# Just commands to configure a new bluefin system

- `just hostname HOST`
  - Set the hostname = HOST

- `just rebase`
  - First rebase if you want to change channel
  - **`reboot` when finished**

- `just first`
  - Run all the recipes that need a reboot
  - Will setup dotfiles and pull in ansible repo
  - **`reboot` when finished**

- `just user`
  - Setup user ansible roles
  - Setup user options from `ujust`
  - Install brew bundle

- `just -f bluefin2.0.just nvidia-laptop`
  - If you are using an nvidia laptop GPU
  - **`reboot` when finished**

- `just quick-set-apps TARGET`
  - Download app profiles and files from another machine (TARGET) via ssh
  - Make sure the apps are not running on TARGET when run
  - Uses the logged in user name for remote machine 