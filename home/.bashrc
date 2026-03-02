# ~/.bashrc
# Lightweight bash configuration

# Early return if non-interactive
[[ -z "$PS1" ]] && return

# Source /etc/bashrc if it exists
[ -f /etc/bashrc ] && . /etc/bashrc

# Source shared shell environment and aliases
for file in ~/.shell/{env,aliases,functions}.sh; do
  [[ -f "$file" ]] && source "$file"
done

# macOS-specific functions/aliases
[[ $(uname -s) == "Darwin" ]] && [[ -f ~/.shell/mac.sh ]] && source ~/.shell/mac.sh

# Direnv hook (before prompt init)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook bash)"
fi

# Starship prompt (only if available)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init bash)"
fi

# fzf keybindings (if available)
[[ -f ~/.fzf.bash ]] && source ~/.fzf.bash

# Bash history and settings
HISTCONTROL=ignoreboth
HISTSIZE=100000
HISTFILESIZE=100000
shopt -s histappend
shopt -s checkwinsize
shopt -s nocaseglob
shopt -s globstar

# Load machine-local config (intentionally last)
[[ -f ~/.bashrc.local ]] && source ~/.bashrc.local
