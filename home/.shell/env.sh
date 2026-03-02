# ~/.shell/env.sh
# Shared environment variables and PATH setup for zsh and bash

# PATH setup: prepend .local/bin for common local utilities
export PATH="$HOME/.local/bin:/usr/local/bin:/usr/local/sbin:${PATH}"

# Editor
export VISUAL="nvim"
export EDITOR="$VISUAL"

# FZF: use ripgrep, exclude .git
if command -v rg >/dev/null 2>&1; then
  export FZF_DEFAULT_COMMAND='rg --files --hidden --follow --glob "!.git/*"'
  export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
fi

# Less
export LESS="-R"
export MANPAGER="less -X"

# Umask
umask 022
