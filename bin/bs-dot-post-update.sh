#!/bin/bash

set -e

get_path() {
  printf "$( cd "$1" >/dev/null 2>&1 && pwd )"
}

function pushd () {
    command pushd "$@" >/dev/null 2>&1
}

function popd () {
    command popd "$@" >/dev/null 2>&1
}

BIN_DIR=$( get_path $( dirname "${BASH_SOURCE[0]}" ) )
ROOT_DIR=$( get_path "$BIN_DIR/.." )
EXTERNAL_DIR="$ROOT_DIR/external"


SPACESHIP_FILE="$EXTERNAL_DIR/spaceship-prompt/spaceship.zsh-theme"
SPACESHIP_LINK="$EXTERNAL_DIR/oh-my-zsh/custom/themes/spaceship.zsh-theme"
if [ ! -L "$SPACESHIP_LINK" ]; then
  printf "\nInstalling Spaceship theme symlink...\n"
  ln -s "$SPACESHIP_FILE" "$SPACESHIP_LINK"
fi

printf "\nInstalling fzf ...\n"
external/fzf/install --all

printf "Post-update tasks complete\n"
