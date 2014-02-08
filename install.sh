#!/bin/bash

# This install happily taken from
# http://github.com/jferris/config_files
# and then tweaked to ignore more than one file

cutstring="DO NOT EDIT BELOW THIS LINE"
ignorefiles="doc source bin external LICENSE README.md install.sh update_submodules.sh oh-my-zsh"
showignore=true

# Iterate over all the files in the directory
for name in *; do
	# If it's not in our ignorefiles list, process it
	if [[ ! $ignorefiles =~ $name ]]; then
		target="$HOME/.$name"

		if [ -e $target ]; then
			if [ ! -L $target ]; then
				cutline=`grep -n -m1 "$cutstring" "$target" | sed "s/:.*//"`
				if [[ -n $cutline ]]; then
					let "cutline = $cutline - 1"
					echo "Updating $target"
					head -n $cutline "$target" > update_tmp
					startline=`tail -r "$name" | grep -n -m1 "$cutstring" | sed "s/:.*//"`
					if [[ -n $startline ]]; then
						tail -n $startline "$name" >> update_tmp
					else
						cat "$name" >> update_tmp
					fi
					mv update_tmp "$target"
				else
					echo "WARNING: $target exists but is not a symlink."
				fi
			fi

		else
			echo "Creating $target"
			if [[ -n `grep "$cutstring" "$name"` ]]; then
				cp "$PWD/$name" "$target"
			else
				ln -s "$PWD/$name" "$target"
			fi
		fi

	else
		# This file is in our ignore list
		if $showignore; then
			echo "Ignoring $name"
		fi
	fi
done

# Post-install, create some vim dirs
echo "Creating Vim directories..."
mkdir -p ~/.vim/tmp/backup
mkdir -p ~/.vim/tmp/swap
mkdir -p ~/.vim/tmp/undo

echo "Done!"
