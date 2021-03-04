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

pushd "$ROOT_DIR"

printf "Updating all submodules to master branch...\n"
git submodule foreach 'git checkout master && git pull origin master'

popd

printf "All submodules updated\n"
