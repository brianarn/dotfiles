#!/usr/bin/env bash
# Migrate from stow-based dotfiles to the new symlink-based system.
#
# This script:
#   1. Migrates directory symlinks (~/.config, ~/.vim) by preserving
#      untracked contents into real directories
#   2. Removes all old stow-based symlinks
#
# Usage: ./scripts/migrate.sh [--dry-run] [--force]
#
# After running, execute ./install.sh to set up the new symlinks.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/lib.sh"

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

migrate_stow_dir() {
  local dotfile="$1"        # e.g. ".config" or ".vim"
  local stow_name="$2"      # e.g. "dot-config" or "dot-vim"
  local target="$HOME/$dotfile"

  if [[ ! -L "$target" ]]; then
    info "~/$dotfile is not a symlink, nothing to migrate"
    return 0
  fi

  local link_dest
  link_dest="$(readlink "$target")"
  if [[ "$link_dest" != *"/stow/$stow_name"* && "$link_dest" != *".dotfiles/stow/$stow_name"* ]]; then
    info "~/$dotfile doesn't point to stow, skipping"
    return 0
  fi

  header "Migrating ~/$dotfile"

  # Resolve the actual directory the symlink points to
  local real_dir
  if [[ "$link_dest" == /* ]]; then
    real_dir="$link_dest"
  else
    real_dir="$HOME/$link_dest"
  fi

  if [[ ! -d "$real_dir" ]]; then
    warn "Stow directory not found at $real_dir, just removing symlink"
    run rm "$target"
    run mkdir -p "$target"
    return 0
  fi

  # Collect untracked items (things that aren't in our managed home/ tree)
  local managed_dir="$DOTFILES_HOME/$dotfile"
  local untracked=()

  while IFS= read -r item; do
    local name
    name="$(basename "$item")"
    if [[ ! -e "$managed_dir/$name" ]]; then
      untracked+=("$item")
    fi
  done < <(find "$real_dir" -mindepth 1 -maxdepth 1 2>/dev/null)

  log "Found ${#untracked[@]} untracked item(s) in ~/$dotfile to preserve"

  # Remove the symlink
  info "Removing ~/$dotfile symlink (pointed to $link_dest)"
  run rm "$target"

  # Create real directory
  run mkdir -p "$target"

  # Copy untracked items into the real directory
  for item in "${untracked[@]}"; do
    local name
    name="$(basename "$item")"
    local dest="$target/$name"
    if [[ -e "$dest" ]]; then
      warn "Cannot move $name to ~/$dotfile/ — already exists"
      continue
    fi
    info "Preserving untracked: ~/$dotfile/$name"
    copy_preserved_item "$item" "$dest"
  done

  log "~/$dotfile migration complete"
}

remove_stow_symlinks_under() {
  local root="$1"
  [[ -d "$root" ]] || return 0

  local removed=0
  while IFS= read -r link; do
    if is_stow_symlink "$link"; then
      local rel="${link#"$HOME/"}"
      info "Removing nested stow symlink: ~/$rel → $(readlink "$link")"
      run rm "$link"
      ((removed++)) || true
    fi
  done < <(find "$root" -type l 2>/dev/null)

  if [[ "$removed" -gt 0 ]]; then
    log "Removed $removed nested stow symlink(s) under $root"
  fi
}

remove_stow_symlinks() {
  header "Removing stow symlinks"

  local removed=0
  local skipped=0

  for dotfile in "${STOW_DOTFILES[@]}"; do
    local target="$HOME/$dotfile"

    # Skip dirs handled separately by migrate_stow_dir
    if [[ "$dotfile" == ".config" || "$dotfile" == ".vim" ]]; then
      continue
    fi

    if [[ ! -L "$target" ]]; then
      continue
    fi

    if is_stow_symlink "$target"; then
      info "Removing stow symlink: $target → $(readlink "$target")"
      run rm "$target"
      ((removed++)) || true
    else
      info "Skipping $target (not a stow symlink)"
      ((skipped++)) || true
    fi
  done

  log "Removed $removed stow symlink(s), skipped $skipped"
}

prepare_managed_targets() {
  header "Checking for install blockers"

  local blocked=0

  while IFS= read -r rel; do
    local src="$DOTFILES_HOME/$rel"
    local target="$HOME/$rel"

    # Only check file entries (install.sh only links non-directories)
    if [[ -d "$src" && ! -L "$src" ]]; then
      continue
    fi

    if [[ -L "$target" ]]; then
      local current
      current="$(readlink "$target")"
      if [[ "$current" == "$src" ]]; then
        continue
      fi
      if is_stow_symlink "$target"; then
        info "Removing stale stow symlink: ~/$rel → $current"
        run rm "$target"
      elif [[ "$FORCE" -eq 1 ]]; then
        backup_path "$target"
      else
        warn "~/$rel exists as symlink → $current (rerun with --force to override)"
        ((blocked++)) || true
      fi
      continue
    fi

    if [[ -e "$target" ]]; then
      if [[ "$FORCE" -eq 1 ]]; then
        backup_path "$target"
      else
        warn "~/$rel exists and is not a symlink (rerun with --force to override)"
        ((blocked++)) || true
      fi
    fi
  done < <(cd "$DOTFILES_HOME" && find . -mindepth 1 | sed 's|^\./||' | sort)

  if [[ "$blocked" -gt 0 ]]; then
    warn "$blocked managed path(s) will block install; rerun migrate.sh --force to back them up"
  else
    log "No install blockers found"
  fi
}

cleanup_base16() {
  header "Cleaning up old base16-shell"

  # Remove the old submodule worktree
  local submodule_path="$DOTFILES_ROOT/external/base16-shell"
  if [[ -d "$submodule_path" ]]; then
    info "Removing $submodule_path"
    run rm -rf "$submodule_path"
  else
    info "external/base16-shell already removed"
  fi

  # Remove the cached git module
  local git_module_path="$DOTFILES_ROOT/.git/modules/external/base16-shell"
  if [[ -d "$git_module_path" ]]; then
    info "Removing $git_module_path"
    run rm -rf "$git_module_path"
  else
    info ".git/modules/external/base16-shell already removed"
  fi

  # Remove the .gitmodules entry if it still exists
  local gitmodules="$DOTFILES_ROOT/.gitmodules"
  if [[ -f "$gitmodules" ]] && grep -q 'submodule "external/base16-shell"' "$gitmodules" 2>/dev/null; then
    info "Removing base16-shell entry from .gitmodules"
    run git config --file "$gitmodules" --remove-section 'submodule.external/base16-shell'
  else
    info ".gitmodules entry for base16-shell already removed"
  fi

  # Remove ~/.base16_theme if it points to the old base16-shell
  local theme_link="$HOME/.base16_theme"
  if [[ -L "$theme_link" ]]; then
    local link_dest
    link_dest="$(readlink "$theme_link")"
    if [[ "$link_dest" == *"base16-shell"* ]]; then
      info "Removing ~/.base16_theme (pointed to $link_dest)"
      run rm "$theme_link"
    else
      info "~/.base16_theme does not point to base16-shell, skipping"
    fi
  else
    info "~/.base16_theme not found or not a symlink"
  fi

  log "base16-shell cleanup complete"
}

cleanup_oh_my_zsh() {
  header "Cleaning up oh-my-zsh (if present)"

  # Remove the OMZ submodule worktree
  local submodule_path="$DOTFILES_ROOT/external/oh-my-zsh"
  if [[ -d "$submodule_path" ]]; then
    info "Removing $submodule_path"
    run rm -rf "$submodule_path"
  else
    info "external/oh-my-zsh already removed"
  fi

  # Remove the cached git module
  local git_module_path="$DOTFILES_ROOT/.git/modules/external/oh-my-zsh"
  if [[ -d "$git_module_path" ]]; then
    info "Removing $git_module_path"
    run rm -rf "$git_module_path"
  else
    info ".git/modules/external/oh-my-zsh already removed"
  fi

  # Remove the .gitmodules entry if it still exists
  local gitmodules="$DOTFILES_ROOT/.gitmodules"
  if [[ -f "$gitmodules" ]] && grep -q 'submodule "external/oh-my-zsh"' "$gitmodules" 2>/dev/null; then
    info "Removing oh-my-zsh entry from .gitmodules"
    run git config --file "$gitmodules" --remove-section 'submodule.external/oh-my-zsh'
  else
    info ".gitmodules entry for oh-my-zsh already removed"
  fi

  log "oh-my-zsh cleanup complete"
}

main() {
  parse_global_flags "$@"

  header "Dotfiles migration: stow → symlinks"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    log "Running in dry-run mode — no changes will be made"
  fi

  # Step 1: Handle directory symlinks and clean up nested stow symlinks
  for entry in "${STOW_DIRS[@]}"; do
    local dotfile="${entry%%:*}"
    local stow_name="${entry##*:}"
    migrate_stow_dir "$dotfile" "$stow_name"
    remove_stow_symlinks_under "$HOME/$dotfile"
  done

  # Step 2: Remove all other stow symlinks
  remove_stow_symlinks

  # Step 3: Remove old base16-shell (replaced by tinted-shell)
  cleanup_base16

  # Step 4: Remove oh-my-zsh (replaced by lightweight starship+shared shell config)
  cleanup_oh_my_zsh

  # Step 5: Check for files that will block install.sh
  prepare_managed_targets

  header "Migration complete!"
  log ""
  log "Next step: run ./install.sh to set up new symlinks"
}

main "$@"
