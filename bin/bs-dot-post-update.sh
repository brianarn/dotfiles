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
OMZ_DIR="$EXTERNAL_DIR/oh-my-zsh"
OMZ_CUSTOM_THEMES_DIR="$OMZ_DIR/custom/themes"

SPACESHIP_DIR="$EXTERNAL_DIR/spaceship-prompt"
SPACESHIP_FILE="$SPACESHIP_DIR/spaceship.zsh-theme"
SPACESHIP_LINK="$OMZ_CUSTOM_THEMES_DIR/spaceship.zsh-theme"
if [ ! -L "$SPACESHIP_LINK" ]; then
  printf "\nInstalling Spaceship theme symlink ...\n"
  ln -s "$SPACESHIP_FILE" "$SPACESHIP_LINK"
fi

CUSTOM_THEMES_DIR="$ROOT_DIR/misc/custom-omz-themes"
BRIANARN_THEME="brianarn.zsh-theme"
BRIANARN_FILE="$CUSTOM_THEMES_DIR/$BRIANARN_THEME"
BRIANARN_LINK="$OMZ_CUSTOM_THEMES_DIR/$BRIANARN_THEME"
printf "CUSTOM_THEMES_DIR=$CUSTOM_THEMES_DIR\n";
if [ ! -L "$BRIANARN_LINK" ]; then
  printf "\nInstalling brianarn theme symlink ...\n"
  ln -s "$BRIANARN_FILE" "$BRIANARN_LINK"
fi

printf "\nInstalling fzf ...\n"
external/fzf/install --all

printf "Post-update tasks complete\n"
