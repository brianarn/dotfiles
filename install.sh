#!/usr/bin/env bash
# Dotfiles installer
# Usage: ./install.sh [--dry-run] [--force] [--quiet] [install|update]

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/scripts/lib.sh"
source "$SCRIPT_DIR/scripts/post-update.sh"

CUTSTRING="DO NOT EDIT BELOW THIS LINE"

usage() {
  cat <<EOF
Usage: ./install.sh [options] [command]

Commands:
  install   Install dotfiles (default)
  update    Update submodules and run post-update tasks

Options:
  --dry-run   Show what would be done without making changes
  --force     Overwrite existing files (backs up originals)
  --quiet     Suppress informational output
  -h, --help  Show this help message
EOF
}

init_submodules() {
  header "Initializing submodules"
  run git -C "$DOTFILES_ROOT" submodule update --init
  log "Submodules initialized"
}

update_submodules() {
  header "Updating submodules"
  run git -C "$DOTFILES_ROOT" submodule update --remote --merge
  log "Submodules updated"
}

install_links() {
  header "Linking dotfiles"
  link_tree "$DOTFILES_HOME"
  log "Dotfiles linked"
}

install_copies() {
  header "Installing copied files"
  merge_cutstring "$DOTFILES_COPY/gitconfig" "$HOME/.gitconfig" "$CUTSTRING"
  copy_if_missing "$DOTFILES_COPY/vimrc.local" "$HOME/.vimrc.local"
  copy_if_missing "$DOTFILES_COPY/vimplug.local" "$HOME/.vimplug.local"
  log "Copied files installed"
}

create_vim_dirs() {
  header "Creating Vim directories"
  local vim_tmp="$HOME/.vim/tmp"
  for dir in backup swap undo; do
    local target="$vim_tmp/$dir"
    if [[ ! -d "$target" ]]; then
      info "Creating $target"
      run mkdir -p "$target"
    fi
  done
  log "Vim directories ready"
}

cmd_install() {
  header "Dotfiles install"
  init_submodules
  install_links
  prune_dead_links
  install_copies
  create_vim_dirs
  run_post_update
  header "Install complete!"
}

cmd_update() {
  header "Dotfiles update"
  update_submodules
  run_post_update
  header "Update complete!"
}

main() {
  parse_global_flags "$@"
  set -- "${PARSED_ARGS[@]+"${PARSED_ARGS[@]}"}"

  local command="${1:-install}"

  case "$command" in
    install) cmd_install ;;
    update)  cmd_update ;;
    -h|--help|help) usage ;;
    *)
      die "Unknown command: $command (try: install, update)"
      ;;
  esac
}

main "$@"
