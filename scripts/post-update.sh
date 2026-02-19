#!/usr/bin/env bash
# Post-install/update tasks: theme symlinks, fzf, pnpm completion
# Sourced by install.sh; can also be run standalone.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/lib.sh"

run_post_update() {
  local root="$DOTFILES_ROOT"
  local external="$root/external"

  header "Post-update tasks"

  # Spaceship theme symlink into oh-my-zsh
  local omz_themes="$external/oh-my-zsh/custom/themes"
  local spaceship_src="$external/spaceship-prompt/spaceship.zsh-theme"
  local spaceship_link="$omz_themes/spaceship.zsh-theme"

  if [[ -d "$external/oh-my-zsh" && -d "$external/spaceship-prompt" ]]; then
    if [[ ! -d "$omz_themes" ]]; then
      run mkdir -p "$omz_themes"
    fi
    if [[ -f "$spaceship_src" ]]; then
      link_one "$spaceship_src" "$spaceship_link"
    else
      warn "Spaceship theme file not found: $spaceship_src"
    fi
  else
    info "oh-my-zsh or spaceship-prompt submodule not present, skipping theme link"
  fi

  # Custom brianarn theme symlink
  local custom_themes="$root/misc/custom-omz-themes"
  local brianarn_src="$custom_themes/brianarn.zsh-theme"
  local brianarn_link="$omz_themes/brianarn.zsh-theme"

  if [[ -d "$external/oh-my-zsh" && -f "$brianarn_src" ]]; then
    link_one "$brianarn_src" "$brianarn_link"
  else
    info "oh-my-zsh or brianarn theme not present, skipping theme link"
  fi

  # Install fzf
  local fzf_install="$external/fzf/install"
  if [[ -x "$fzf_install" ]]; then
    log "Installing fzf..."
    run "$fzf_install" --all
  else
    info "fzf submodule not present or install script not found, skipping"
  fi

  # Generate pnpm completion
  if command -v pnpm >/dev/null 2>&1; then
    log "Generating pnpm zsh completion..."
    if [[ "$DRY_RUN" -eq 1 ]]; then
      info "[dry-run] Would generate pnpm completion to ~/.pnpm-completion.zsh"
    else
      pnpm completion zsh > "$HOME/.pnpm-completion.zsh"
    fi
  else
    info "pnpm not found, skipping completion generation"
  fi

  log "Post-update tasks complete"
}

# Allow running standalone
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  parse_global_flags "$@"
  run_post_update
fi
