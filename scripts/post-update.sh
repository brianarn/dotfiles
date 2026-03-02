#!/usr/bin/env bash
# Post-install/update tasks: fzf, pnpm completion
# Sourced by install.sh; can also be run standalone.

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/lib.sh"

run_post_update() {
  local root="$DOTFILES_ROOT"
  local external="$root/external"

  header "Post-update tasks"

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
      local tmp
      tmp="$(mktemp "$HOME/.pnpm-completion.zsh.tmp.XXXXXX")"
      if pnpm completion zsh > "$tmp"; then
        mv "$tmp" "$HOME/.pnpm-completion.zsh"
      else
        rm -f "$tmp"
        warn "pnpm completion generation failed"
      fi
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
