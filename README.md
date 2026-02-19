# Brian Sinclair's dotfiles

This is my set of dotfiles. It's nothing terribly special, really. Kind of a
mess, even.

Apparently I started saving these in here in 2010 and now I feel really old.

## Installation

    git clone https://github.com/brianarn/dotfiles.git $HOME/.dotfiles
    cd $HOME/.dotfiles
    ./install.sh

### Migrating from stow-based setup

If you previously used the stow-based dotfiles on this machine:

    ./scripts/migrate.sh        # Remove old stow symlinks (preserves ~/.config contents)
    ./install.sh                # Set up new symlinks

Use `--dry-run` to preview what either script will do before making changes.

## Usage

### Install

    ./install.sh [--dry-run] [--force] [--quiet]

Sets up symlinks from `home/` into `$HOME`, merges managed config files,
initializes submodules, and runs post-update tasks.

### Update

    ./install.sh update [--dry-run] [--force] [--quiet]

Updates git submodules and re-runs post-update tasks (fzf, shell completions,
oh-my-zsh themes).

### Doctor

    ./scripts/doctor.sh

Analyzes the current installation and reports issues: missing symlinks,
stale stow links, uninitialized submodules, missing tools, etc.

## Structure

- `home/` — Dotfiles symlinked into `$HOME` (mirrors the target directory structure)
- `copy/` — Files copied (not symlinked) to allow machine-local customization
- `external/` — Git submodules (oh-my-zsh, fzf, base16-shell, spaceship-prompt)
- `misc/` — Extras (custom themes, git template)
- `scripts/` — Install helpers, migration, and doctor

## Credits

Thanks to the awesome MIT license usage, I took Joe Ferris' install.sh
from his project at http://github.com/jferris/config_files and modified it
to allow me a simple list of files to skip. It's far from perfect, but
it's also functional, and works sufficiently well enough.

In particular, I like that it allows for local options with a section where
one can supply a cutline, and all content after that will be overwritten by
the installer.
