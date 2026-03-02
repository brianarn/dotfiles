# ~/.zshrc
# Lightweight zsh configuration with starship prompt

# Early return if non-interactive (prevents shell scripts from sourcing this)
[[ -o interactive ]] || return

# Colors (tinted-shell base16/base24)
[[ -f ~/.shell/colors.sh ]] && source ~/.shell/colors.sh

# Source shared shell environment and aliases
for file in ~/.shell/{env,aliases,functions}.sh; do
  [[ -f "$file" ]] && source "$file"
done

# macOS-specific functions/aliases
[[ "$(uname -s)" == "Darwin" ]] && [[ -f ~/.shell/mac.sh ]] && source ~/.shell/mac.sh

# Direnv hook (before prompt init, so direnv-managed vars are available)
if command -v direnv >/dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

# Starship prompt (only if available)
if command -v starship >/dev/null 2>&1; then
  eval "$(starship init zsh)"
fi

# fzf keybindings
if [[ -f ~/.fzf.zsh ]]; then
  source ~/.fzf.zsh
fi

# pnpm shell completion
if [[ -f ~/.pnpm-completion.zsh ]]; then
  source ~/.pnpm-completion.zsh
fi

# Zsh-specific history and completion settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
setopt HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_FIND_NO_DUPS
setopt INC_APPEND_HISTORY SHARE_HISTORY

# Load machine-local config (intentionally last, overrides everything)
[[ -f ~/.zshrc.local ]] && source ~/.zshrc.local
