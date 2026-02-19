#!/usr/bin/env bash
# Shared library for dotfiles scripts
# Source this file; do not execute directly.

set -euo pipefail

# --- Configuration ---
DRY_RUN="${DRY_RUN:-0}"
FORCE="${FORCE:-0}"
QUIET="${QUIET:-0}"

DOTFILES_ROOT="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd -P)"
DOTFILES_HOME="$DOTFILES_ROOT/home"
DOTFILES_COPY="$DOTFILES_ROOT/copy"

# --- Colors ---
if [[ -t 2 ]]; then
  _RED=$'\033[0;31m'
  _YELLOW=$'\033[0;33m'
  _GREEN=$'\033[0;32m'
  _CYAN=$'\033[0;36m'
  _BOLD=$'\033[1m'
  _RESET=$'\033[0m'
else
  _RED='' _YELLOW='' _GREEN='' _CYAN='' _BOLD='' _RESET=''
fi

# --- Logging ---
log() {
  [[ "$QUIET" -eq 1 ]] && return
  printf '%s%s%s\n' "$_GREEN" "$*" "$_RESET" >&2
}

info() {
  [[ "$QUIET" -eq 1 ]] && return
  printf '%s%s%s\n' "$_CYAN" "$*" "$_RESET" >&2
}

warn() {
  printf '%sWARN: %s%s\n' "$_YELLOW" "$*" "$_RESET" >&2
}

die() {
  printf '%sERROR: %s%s\n' "$_RED" "$*" "$_RESET" >&2
  exit 1
}

header() {
  [[ "$QUIET" -eq 1 ]] && return
  printf '\n%s%s=== %s ===%s\n' "$_BOLD" "$_GREEN" "$*" "$_RESET" >&2
}

# --- Helpers ---
run() {
  if [[ "$DRY_RUN" -eq 1 ]]; then
    info "[dry-run] $*"
  else
    "$@"
  fi
}

backup_path() {
  local target="$1"
  local ts
  ts="$(date +%Y%m%d%H%M%S)"
  local backup="${target}.dotfiles-bak.${ts}"
  info "Backing up $target → $backup"
  run mv "$target" "$backup"
}

ensure_parent_dir() {
  local parent
  parent="$(dirname "$1")"
  if [[ ! -d "$parent" ]]; then
    run mkdir -p "$parent"
  fi
}

# --- Symlink operations ---
link_one() {
  local src="$1" target="$2"

  ensure_parent_dir "$target"

  if [[ -L "$target" ]]; then
    local current
    current="$(readlink "$target")"
    if [[ "$current" = "$src" ]]; then
      return 0
    fi
    if [[ "$FORCE" -eq 1 ]]; then
      info "Relinking $target"
      run ln -sf "$src" "$target"
    else
      warn "Skipping $target (symlink points to $current, expected $src)"
    fi
    return 0
  fi

  if [[ -e "$target" ]]; then
    if [[ "$FORCE" -eq 1 ]]; then
      backup_path "$target"
      info "Linking $target → $src"
      run ln -s "$src" "$target"
    else
      warn "Skipping $target (exists and is not a symlink; use --force to override)"
    fi
    return 0
  fi

  info "Linking $target → $src"
  run ln -s "$src" "$target"
}

link_tree() {
  local source_dir="$1"
  [[ -d "$source_dir" ]] || die "Source directory not found: $source_dir"

  while IFS= read -r rel; do
    local src="$source_dir/$rel"
    local target="$HOME/$rel"

    if [[ -d "$src" && ! -L "$src" ]]; then
      if [[ ! -d "$target" ]]; then
        run mkdir -p "$target"
      fi
    else
      link_one "$src" "$target"
    fi
  done < <(cd "$source_dir" && find . -mindepth 1 | sed 's|^\./||' | sort)
}

# --- Copy/merge operations ---
copy_if_missing() {
  local src="$1" target="$2"

  ensure_parent_dir "$target"

  if [[ -e "$target" ]]; then
    info "Exists, skipping: $target"
    return 0
  fi

  info "Copying $src → $target"
  run cp "$src" "$target"
}

merge_cutstring() {
  local src="$1" target="$2" cutstring="$3"

  ensure_parent_dir "$target"

  if [[ ! -e "$target" ]]; then
    info "Creating $target (from $src)"
    run cp "$src" "$target"
    return 0
  fi

  if ! grep -qF "$cutstring" "$src"; then
    warn "Source missing cutstring, skipping merge: $src"
    return 0
  fi

  if ! grep -qF "$cutstring" "$target"; then
    warn "Target missing cutstring, skipping merge: $target"
    return 0
  fi

  info "Merging managed content into $target"

  if [[ "$DRY_RUN" -eq 1 ]]; then
    info "[dry-run] Would merge $src into $target (preserving content above cutstring)"
    return 0
  fi

  local tmp
  tmp="$(mktemp "${target}.tmp.XXXXXX")"

  # Keep everything above the cutstring from the target (user's local config)
  awk -v cut="$cutstring" 'index($0, cut) { exit } { print }' "$target" > "$tmp"

  # Append everything from the cutstring onward from the source (managed config)
  awk -v cut="$cutstring" 'found { print; next } index($0, cut) { found=1; print }' "$src" >> "$tmp"

  mv "$tmp" "$target"
}

# --- Argument parsing ---
parse_global_flags() {
  local args=()
  while [[ $# -gt 0 ]]; do
    case "$1" in
      --dry-run) DRY_RUN=1 ;;
      --force)   FORCE=1 ;;
      --quiet)   QUIET=1 ;;
      *)         args+=("$1") ;;
    esac
    shift
  done
  PARSED_ARGS=("${args[@]+"${args[@]}"}")
}
