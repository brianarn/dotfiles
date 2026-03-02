# Tinted Shell (base16/base24 color setup)
# https://github.com/tinted-theming/tinted-shell
# Sourced by both .zshrc and .bashrc

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
  if [ -n "$ZSH_VERSION" ]; then
    if (( $+functions[set_theme] )); then
      functions[_tinted_original_set_theme]=$functions[set_theme]
      set_theme() {
        _tinted_original_set_theme "$@"
        echo "base16" >| "$BASE16_CONFIG_PATH/theme_system"
      }
    fi
  elif [ -n "$BASH_VERSION" ]; then
    if declare -f set_theme >/dev/null 2>&1; then
      eval "_tinted_original_set_theme() $(declare -f set_theme | tail -n +2)"
      set_theme() {
        _tinted_original_set_theme "$@"
        echo "base16" >| "$BASE16_CONFIG_PATH/theme_system"
      }
    fi
  fi

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
      if [ -n "$ZSH_VERSION" ]; then
        for hook in "$BASE16_SHELL_HOOKS_PATH"/*.sh(N-.); do
          [ -r "$hook" ] && . "$hook"
        done
      else
        for hook in "$BASE16_SHELL_HOOKS_PATH"/*.sh; do
          [ -r "$hook" ] && . "$hook"
        done
      fi
    fi
  }

  # Generate base24_* aliases
  if [ -n "$ZSH_VERSION" ]; then
    for _b24_script in "$BASE16_SHELL_PATH"/scripts/base24-*.sh(N-.); do
      _b24_name=${_b24_script##*/}
      _b24_slug=${_b24_name#base24-}
      _b24_slug=${_b24_slug%.sh}
      alias "base24_${_b24_slug}"="set_base24_theme '${_b24_slug}'"
    done
  else
    for _b24_script in "$BASE16_SHELL_PATH"/scripts/base24-*.sh; do
      [ -f "$_b24_script" ] || continue
      _b24_name=${_b24_script##*/}
      _b24_slug=${_b24_name#base24-}
      _b24_slug=${_b24_slug%.sh}
      alias "base24_${_b24_slug}"="set_base24_theme '${_b24_slug}'"
    done
  fi
  unset _b24_script _b24_name _b24_slug
fi
