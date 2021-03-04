# Brian Sinclair's dotfiles

This is my set of dotfiles. It's nothing terribly special, really. Kind of a
mess, even.

Apparently I started saving these in here in 2010 and now I feel really old.

## Requirements

- Stow 2.3+ (for `--dotfiles` flag)

## Installation

    git clone git@github.com:brianarn/dotfiles.git $HOME/.dotfiles
    make

### Mac-specific

There's a `Brewfile` in the `misc` directory.

    brew bundle --file $HOME/.dotfiles/misc/Brewfile

## Updating submodules

It's a good idea to update those once in awhile.

    make update

## Credits

Thanks to the awesome MIT license usage, I took Joe Ferris' install.sh
from his project at http://github.com/jferris/config_files and modified it
to allow me a simple list of files to skip. It's far from perfect, but
it's also functional, and works sufficiently well enough.

In particular, I like that it allows for local options with a section where
one can supply a cutline, and all content after that will be overwritten by
the installer.
