#!/bin/sh
printf "Updating all submodules to master branch...\n"
git submodule foreach 'git checkout master && git pull origin master'

printf "\nSetting up Spaceship theme...\n"
EXTROOT="$HOME/.dotfiles/external"
ln -s "$EXTROOT/spaceship-prompt/spaceship.zsh-theme" "$EXTROOT/oh-my-zsh/custom/themes/spaceship.zsh-theme"

printf "\nInstalling fzf ...\n"
external/fzf/install --all

printf "\nDone!\n"
