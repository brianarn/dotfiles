#!/bin/bash

# This install script inspired by
# http://github.com/jferris/config_files

CUTSTRING="DO NOT EDIT BELOW THIS LINE"
STOWFILES="bash fzf misc tmux vim zsh"
COPYFILES="gitconfig"

function log {
  printf -- "\n$1\n"
}

log '=== dotfiles install ==='

# Set up submodules
log "--- Initializing git submodules..."
git submodule update --init

# Do the stow thing
log '--- Stowing files...'
stow --stow --dotfiles --verbose stow

# TODO This isn't working because of tail -r and also the awk command not working
# Need to pursue better option
# log '--- Copying files...'
#for file in $COPYFILES; do
#  target="$HOME/.$file"
#  log "Processing $file..."
#
#  if [ -e $target ]; then
#    if [ ! -L $target ]; then
#      cutline=`grep -n -m1 "$CUTSTRING" "$target" | sed "s/:.*//"`
#      if [[ -n $cutline ]]; then
#        let "cutline = $cutline - 1"
#        log "Updating $target"
#        head -n $cutline "$target" > update_tmp
#        startline=`awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' "$name" | grep -n -m1 "$CUTSTRING" | sed "s/:.*//"`
#        if [[ -n $startline ]]; then
#          tail -n $startline "$file" >> update_tmp
#        else
#          cat "$file" >> update_tmp
#        fi
#        mv update_tmp "$target"
#      else
#        log "WARNING: $target exists but is not a symlink."
#      fi
#    fi
#
#  else
#    log "Creating $target"
#    if [[ -n `grep "$CUTSTRING" "$file"` ]]; then
#      cp "$PWD/$file" "$target"
#    else
#      ln -s "$PWD/$file" "$target"
#    fi
#  fi
#done
log '--- Copying files...'
for file in $COPYFILES; do
  target="$HOME/.$file"
  if [ -f "$target" ]; then
    log ".$file exists, skipping..."
  else
    log "Copying $file to $target"
    cp "$PWD/copy_src/$file" "$target"
  fi
done

# Post-install, create some vim dirs
log "--- Creating Vim directories..."
for dir in backup swap undo; do
  VIMDIR="$HOME/.vim/tmp/$dir"
  if [ -d "$VIMDIR" ]; then
    log "$VIMDIR exists, skipping"
  else
    log "Creating $VIMDIR"
    mkdir -p "$VIMDIR"
  fi
done

log "=== Done!"
