# ~/.zshrc
# Lightweight zsh configuration without oh-my-zsh

# Early return if non-interactive (prevents shell scripts from sourcing this)
[[ -o interactive ]] || return

echo "zsh: loading ~/.zshrc"

#### Tinted Shell (base16/base24 color setup)
# https://github.com/tinted-theming/tinted-shell
BASE16_SHELL="$HOME/.dotfiles/external/tinted-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

# base24 support (profile_helper.sh only handles base16 themes)
if [ -n "$BASE16_SHELL_PATH" ]; then
  # Restore base24 theme on startup
  _tinted_sys_file="$BASE16_CONFIG_PATH/theme_system"
  if [ -f "$_tinted_sys_file" ]; then
    read -r _tinted_sys < "$_tinted_sys_file"
    if [ "$_tinted_sys" = "base24" ]; then
      read -r _tinted_name < "$BASE16_SHELL_THEME_NAME_PATH" 2>/dev/null
      if [ -n "$_tinted_name" ] && [ -f "$BASE16_SHELL_PATH/scripts/base24-$_tinted_name.sh" ]; then
        . "$BASE16_SHELL_PATH/scripts/base24-$_tinted_name.sh"
        ln -fs "$BASE16_SHELL_PATH/scripts/base24-$_tinted_name.sh" \
          "$BASE16_SHELL_COLORSCHEME_PATH" >/dev/null
      fi
    fi
  fi
  unset _tinted_sys_file _tinted_sys _tinted_name

  # Wrap set_theme so base16_* aliases clear the base24 marker
  functions[_tinted_original_set_theme]=$functions[set_theme]
  set_theme() {
    _tinted_original_set_theme "$@"
    echo "base16" >| "$BASE16_CONFIG_PATH/theme_system"
  }

  # base24 theme switching
  set_base24_theme() {
    local theme_name="$1"
    local script_path="$BASE16_SHELL_PATH/scripts/base24-$theme_name.sh"
    if [ ! -f "$script_path" ]; then
      echo "base24 theme not found: $theme_name"
      return 1
    fi
    echo "$theme_name" >| "$BASE16_SHELL_THEME_NAME_PATH"
    echo "base24" >| "$BASE16_CONFIG_PATH/theme_system"
    ln -fs "$script_path" "$BASE16_SHELL_COLORSCHEME_PATH" >/dev/null
    . "$script_path"
    if [ -d "$BASE16_SHELL_HOOKS_PATH" ]; then
      for hook in "$BASE16_SHELL_HOOKS_PATH"/*.sh; do
        [ -r "$hook" ] && . "$hook"
      done
    fi
  }

  # Generate base24_* aliases
  for _b24_script in "$BASE16_SHELL_PATH"/scripts/base24-*.sh; do
    _b24_name=${_b24_script##*/}
    _b24_slug=${_b24_name#base24-}
    _b24_slug=${_b24_slug%.sh}
    alias "base24_${_b24_slug}"="set_base24_theme '${_b24_slug}'"
  done
  unset _b24_script _b24_name _b24_slug
fi

# Source shared shell environment and aliases
for file in ~/.shell/{env,aliases,functions}.sh; do
  [[ -f "$file" ]] && source "$file"
done

# macOS-specific functions/aliases
[[ $(uname -s) == "Darwin" ]] && [[ -f ~/.shell/mac.sh ]] && source ~/.shell/mac.sh

# Direnv hook (before prompt init, so direnv-managed vars are available)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Starship prompt (sourcing once, here)
eval "$(starship init zsh)"

# fzf keybindings (if available)
[[ -f ~/.fzf.zsh ]] && source ~/.fzf.zsh

# pnpm shell completion (if available)
[[ -f ~/.pnpm-completion.zsh ]] && source ~/.pnpm-completion.zsh

# Zsh-specific history and completion settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY SHARE_HISTORY

# Keybindings: restore Emacs-mode keys while in vi-mode (optional; remove if you don't use vi-mode)
# Note: vi-mode plugin is no longer loaded from OMZ; if you want it, add here
# bindkey -M viins '^A' beginning-of-line
# bindkey -M viins '^E' end-of-line

# Load machine-local config (intentionally last, overrides everything)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
