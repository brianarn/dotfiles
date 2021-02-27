#!/bin/sh
printf "Updating all submodules to master branch...\n"
git submodule foreach 'git checkout master && git pull origin master'

printf "\nInstalling fzf ...\n"
external/fzf/install --all

printf "\nDone!\n"
