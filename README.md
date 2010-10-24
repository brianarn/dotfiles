# Brian Arnold's dotfiles

This is my set of dotfiles. It's nothing terribly special, really.
Honestly, it could use some cleaning, even. That being said, I'm just
trying to clean up and consolidate things.

## Installation

If for some reason you want to install this yourself, feel free --
or I'll likely use this myself at some point.

	# Clone the repo
	git clone git://github.com/brianarn/dotfiles ~/.dotfiles
	cd ~/.dotfiles

	# Initialize the Git submodules (namely for Vim bundles)
	git submodule update --init

	# Set up symlinks
	./install.sh

	# Go back to where I was
	if [[ $OLDPWD ]]; then cd $OLDPWD; fi

## Credits

Thanks to the awesome MIT license usage, I took Joe Ferris' install.sh
from his project at http://github.com/jferris/config_files and modified it
to allow me a simple list of files to skip. It's far from perfect, but
it's also functional, and works sufficiently well enough.

In particular, I like that it allows for local options with a section where
one can supply a cutline, and all content after that will be overwritten by
the installer.
