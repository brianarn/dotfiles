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
- `external/` — Git submodules (oh-my-zsh, fzf, tinted-shell, spaceship-prompt)
- `misc/` — Extras (custom themes, Moom config)
- `scripts/` — Install helpers, migration, and doctor
