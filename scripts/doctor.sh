#!/usr/bin/env bash
# Dotfiles health checker
# Analyzes the current installation and identifies problems.
#
# Usage: ./scripts/doctor.sh

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd -P)"
source "$SCRIPT_DIR/lib.sh"

ISSUES=0
WARNINGS=0

ok() {
  info "  ✓ $*"
}

problem() {
  printf '  %s✗ %s%s\n' "$_RED" "$*" "$_RESET" >&2
  ((ISSUES++)) || true
}

notice() {
  printf '  %s⚠ %s%s\n' "$_YELLOW" "$*" "$_RESET" >&2
  ((WARNINGS++)) || true
}

# --- Checks ---

check_symlinks() {
  header "Symlink audit"

  local total=0
  local correct=0
  local missing=0
  local wrong=0

  while IFS= read -r rel; do
    local src="$DOTFILES_HOME/$rel"
    local target="$HOME/$rel"

    # Skip directories
    if [[ -d "$src" && ! -L "$src" ]]; then
      continue
    fi

    ((total++)) || true

    if [[ ! -e "$target" && ! -L "$target" ]]; then
      problem "Missing: ~/$rel"
      ((missing++)) || true
      continue
    fi

    if [[ ! -L "$target" ]]; then
      problem "Not a symlink: ~/$rel"
      ((wrong++)) || true
      continue
    fi

    local link_dest
    link_dest="$(readlink "$target")"
    if [[ "$link_dest" == "$src" ]]; then
      ((correct++)) || true
    else
      problem "Wrong target: ~/$rel → $link_dest (expected $src)"
      ((wrong++)) || true
    fi
  done < <(cd "$DOTFILES_HOME" && find . -mindepth 1 | sed 's|^\./||' | sort)

  if [[ "$missing" -eq 0 && "$wrong" -eq 0 ]]; then
    ok "$correct/$total symlinks correct"
  else
    problem "$missing missing, $wrong incorrect out of $total symlinks"
  fi
}

check_copy_files() {
  header "Copied files"

  local gitconfig="$HOME/.gitconfig"
  local cutstring="DO NOT EDIT BELOW THIS LINE"

  if [[ ! -f "$gitconfig" ]]; then
    problem "~/.gitconfig does not exist"
  elif ! grep -qF "$cutstring" "$gitconfig"; then
    notice "~/.gitconfig exists but is missing cutstring — managed content may be out of date"
  else
    ok "~/.gitconfig exists and has cutstring"
  fi
}

check_submodules() {
  header "Submodule status"

  if ! command -v git >/dev/null 2>&1; then
    problem "git not found"
    return
  fi

  local has_issues=0
  while IFS= read -r line; do
    local status="${line:0:1}"
    local rest="${line:1}"
    local path
    path="$(echo "$rest" | awk '{print $2}')"

    case "$status" in
      " ") ok "$path" ;;
      "-")
        problem "$path: not initialized (run ./install.sh)"
        has_issues=1
        ;;
      "+")
        notice "$path: checked out commit differs from index"
        has_issues=1
        ;;
      "U")
        problem "$path: merge conflict"
        has_issues=1
        ;;
    esac
  done < <(git -C "$DOTFILES_ROOT" submodule status 2>/dev/null)

  if [[ "$has_issues" -eq 0 ]]; then
    ok "All submodules healthy"
  fi
}

check_tools() {
  header "Tool availability"

  local required_tools=(git)
  local optional_tools=(nvim vim zsh fzf pnpm tmux)

  for tool in "${required_tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
      ok "$tool: $(command -v "$tool")"
    else
      problem "$tool not found (required)"
    fi
  done

  for tool in "${optional_tools[@]}"; do
    if command -v "$tool" >/dev/null 2>&1; then
      ok "$tool: $(command -v "$tool")"
    else
      notice "$tool not found (optional)"
    fi
  done
}

check_dead_links() {
  header "Dead symlinks"

  local dead=0

  while IFS= read -r target; do
    local link_dest
    link_dest="$(readlink "$target")"
    if [[ "$link_dest" == "$DOTFILES_HOME/"* && ! -e "$target" ]]; then
      local rel="${target#"$HOME/"}"
      problem "Dead symlink: ~/$rel → $link_dest (run ./install.sh)"
      ((dead++)) || true
    fi
  done < <(
    find "$HOME" -maxdepth 1 -type l 2>/dev/null
    while IFS= read -r rel; do
      [[ -d "$HOME/$rel" ]] && find "$HOME/$rel" -type l 2>/dev/null
    done < <(cd "$DOTFILES_HOME" && find . -mindepth 1 -type d 2>/dev/null | sed 's|^\./||' | sort)
  )

  if [[ "$dead" -eq 0 ]]; then
    ok "No dead symlinks found"
  fi
}

check_stale_stow_links() {
  header "Stale stow symlinks"

  local stale=0

  for dotfile in "${STOW_DOTFILES[@]}"; do
    local target="$HOME/$dotfile"
    if [[ -L "$target" ]]; then
      local link_dest
      link_dest="$(readlink "$target")"
      if [[ "$link_dest" == *"/stow/dot-"* || "$link_dest" == *".dotfiles/stow/"* ]]; then
        problem "Stale stow symlink: ~/$dotfile → $link_dest (run scripts/migrate.sh)"
        ((stale++)) || true
      fi
    fi
  done

  if [[ "$stale" -eq 0 ]]; then
    ok "No stale stow symlinks found"
  fi
}

check_vim_dirs() {
  header "Vim directories"

  local vim_tmp="$HOME/.vim/tmp"
  local all_ok=1

  for dir in backup swap undo; do
    local target="$vim_tmp/$dir"
    if [[ -d "$target" ]]; then
      ok "$target"
    else
      problem "Missing: $target"
      all_ok=0
    fi
  done
}

# --- Main ---

main() {
  parse_global_flags "$@"

  header "Dotfiles doctor"

  check_symlinks
  check_copy_files
  check_submodules
  check_tools
  check_dead_links
  check_stale_stow_links
  check_vim_dirs

  echo ""
  if [[ "$ISSUES" -eq 0 && "$WARNINGS" -eq 0 ]]; then
    log "Everything looks good! 🎉"
  elif [[ "$ISSUES" -eq 0 ]]; then
    log "$WARNINGS warning(s), no issues"
  else
    warn "$ISSUES issue(s), $WARNINGS warning(s) found"
  fi

  exit "$( [[ "$ISSUES" -gt 0 ]] && echo 1 || echo 0 )"
}

main "$@"
