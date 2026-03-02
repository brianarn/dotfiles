# ~/.bash_profile
# Login shell config for bash

# Homebrew (macOS only — no-op on Linux or if brew not installed)
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Source .bashrc for interactive settings
if [ -f ~/.bashrc ]; then
  . ~/.bashrc
fi

# Load machine-local config
if [ -f ~/.bash_profile.local ]; then
  . ~/.bash_profile.local
fi
