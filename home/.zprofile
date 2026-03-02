# ~/.zprofile
# Login shell config for zsh

# Homebrew (macOS only — no-op on Linux or if brew not installed)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load machine-local config
if [ -f ~/.zprofile.local ]; then
  . ~/.zprofile.local
fi
