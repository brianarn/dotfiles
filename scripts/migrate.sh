#!/usr/bin/env bash
# Migrate from stow-based dotfiles to the new symlink-based system.
#
# This script:
#   1. Finds symlinks in $HOME that point to the old stow/ directory
#   2. If ~/.config is a symlink to stow/dot-config, moves untracked
#      contents into a real ~/.config directory first
#   3. Removes all old stow-based symlinks
#
# Usage: ./scripts/migrate.sh [--dry-run] [--force]
#
# After running, execute ./install.sh to set up the new symlinks.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/lib.sh"

# Files that were managed by stow (including ones we're no longer tracking).
# Used to identify stow symlinks to remove.
STOW_DOTFILES=(
  .ackrc
  .asdfrc
  .bash_profile
  .bashrc
  .config
  .default-gems
  .gitignore_global
  .gvimrc
  .screenrc
  .slate
  .spacemacs
  .tarexcludes
  .tmux-linux.conf
  .tmux-osx.conf
  .tmux.conf
  .todo.cfg
  .vim
  .vimrc
  .vimrc_background
  .zshrc
)

is_stow_symlink() {
  local target="$1"
  if [[ ! -L "$target" ]]; then
    return 1
  fi
  local link_dest
  link_dest="$(readlink "$target")"
  # Stow created links like .dotfiles/stow/dot-* or absolute paths containing /stow/dot-
  if [[ "$link_dest" == *"/stow/dot-"* || "$link_dest" == *".dotfiles/stow/"* ]]; then
    return 0
  fi
  return 1
}

migrate_config_dir() {
  local config_link="$HOME/.config"

  if [[ ! -L "$config_link" ]]; then
    info "~/.config is not a symlink, nothing to migrate"
    return 0
  fi

  local link_dest
  link_dest="$(readlink "$config_link")"
  if [[ "$link_dest" != *"/stow/dot-config"* && "$link_dest" != *".dotfiles/stow/dot-config"* ]]; then
    info "~/.config doesn't point to stow, skipping config migration"
    return 0
  fi

  header "Migrating ~/.config"

  # Resolve the actual directory the symlink points to
  local real_config
  if [[ "$link_dest" == /* ]]; then
    real_config="$link_dest"
  else
    real_config="$HOME/$link_dest"
  fi

  if [[ ! -d "$real_config" ]]; then
    warn "Stow config directory not found at $real_config, just removing symlink"
    run rm "$config_link"
    run mkdir -p "$config_link"
    return 0
  fi

  # Collect untracked items (things that aren't in our managed home/.config)
  local managed_config="$DOTFILES_HOME/.config"
  local untracked=()

  while IFS= read -r item; do
    local name
    name="$(basename "$item")"
    # Check if this item is managed by our new dotfiles
    if [[ ! -e "$managed_config/$name" ]]; then
      untracked+=("$item")
    fi
  done < <(find "$real_config" -mindepth 1 -maxdepth 1 2>/dev/null)

  log "Found ${#untracked[@]} untracked item(s) in ~/.config to preserve"

  # Remove the symlink
  info "Removing ~/.config symlink (pointed to $link_dest)"
  run rm "$config_link"

  # Create real ~/.config directory
  run mkdir -p "$HOME/.config"

  # Move untracked items into the real ~/.config
  for item in "${untracked[@]}"; do
    local name
    name="$(basename "$item")"
    local dest="$HOME/.config/$name"
    if [[ -e "$dest" ]]; then
      warn "Cannot move $name to ~/.config/ — already exists"
      continue
    fi
    info "Preserving untracked config: $name"
    run cp -R "$item" "$dest"
  done

  log "~/.config migration complete"
}

remove_stow_symlinks() {
  header "Removing stow symlinks"

  local removed=0
  local skipped=0

  for dotfile in "${STOW_DOTFILES[@]}"; do
    local target="$HOME/$dotfile"

    # Skip .config — handled separately by migrate_config_dir
    if [[ "$dotfile" == ".config" ]]; then
      continue
    fi

    if [[ ! -L "$target" ]]; then
      continue
    fi

    if is_stow_symlink "$target"; then
      info "Removing stow symlink: $target → $(readlink "$target")"
      run rm "$target"
      ((removed++))
    else
      info "Skipping $target (not a stow symlink)"
      ((skipped++))
    fi
  done

  log "Removed $removed stow symlink(s), skipped $skipped"
}

main() {
  parse_global_flags "$@"

  header "Dotfiles migration: stow → symlinks"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "Running in dry-run mode — no changes will be made"
  fi

  # Step 1: Handle ~/.config specially (preserve untracked files)
  migrate_config_dir

  # Step 2: Remove all other stow symlinks
  remove_stow_symlinks

  header "Migration complete!"
  log ""
  log "Next step: run ./install.sh to set up new symlinks"
}

main "$@"
