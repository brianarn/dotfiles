#!/bin/bash

# This install script inspired by
# http://github.com/jferris/config_files

CUTSTRING="DO NOT EDIT BELOW THIS LINE"
STOWFILES="bash fzf misc tmux vim zsh"
COPYFILES="gitconfig"

# Do the stow thing
stow --stow --dotfiles --verbose stow

# TODO This isn't working because of tail -r and also the awk command not working
# Need to pursue better option
#for file in $COPYFILES; do
#  target="$HOME/.$file"
#  printf "Processing $file...\n"
#
#  if [ -e $target ]; then
#    if [ ! -L $target ]; then
#      cutline=`grep -n -m1 "$CUTSTRING" "$target" | sed "s/:.*//"`
#      if [[ -n $cutline ]]; then
#        let "cutline = $cutline - 1"
#        printf "Updating $target\n"
#        head -n $cutline "$target" > update_tmp
#        startline=`awk '{a[i++]=$0} END {for (j=i-1; j>=0;) print a[j--] }' "$name" | grep -n -m1 "$CUTSTRING" | sed "s/:.*//"`
#        if [[ -n $startline ]]; then
#          tail -n $startline "$file" >> update_tmp
#        else
#          cat "$file" >> update_tmp
#        fi
#        mv update_tmp "$target"
#      else
#        printf "WARNING: $target exists but is not a symlink.\n"
#      fi
#    fi
#
#  else
#    printf "Creating $target\n"
#    if [[ -n `grep "$CUTSTRING" "$file"` ]]; then
#      cp "$PWD/$file" "$target"
#    else
#      ln -s "$PWD/$file" "$target"
#    fi
#  fi
#done
for file in $COPYFILES; do
	target="$HOME/.$file"
	if [[ -e "$target" ]]; then
		printf ".$file exists, skipping...\n"
	else
		cp "$PWD/$file" "$target"
	fi
done

# Set up submodules
printf "Initializing git submodules...\n"
git submodule update --init

# Post-install, create some vim dirs
printf "Creating Vim directories...\n"
for dir in backup swap undo; do
	VIMDIR="~/.vim/tmp/$dir"
	if [[ -e "$VIMDIR" ]]; then
		printf "$VIMDIR exists, skipping\n"
	else
		printf "Creating $VIMDIR\n"
		mkdir -p "$VIMDIR"
	fi
done

printf "Done!\n"
