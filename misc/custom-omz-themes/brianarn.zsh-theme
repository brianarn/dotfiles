# brianarn's theme
# originally based on https://github.com/blinks zsh theme

function _prompt_char() {
  if $(git rev-parse --is-inside-work-tree >/dev/null 2>&1); then
    echo "%{%F{blue}%}±%{%f%k%b%}"
  else
    echo ' '
  fi
}

# This theme works with both the "dark" and "light" variants of the
# Solarized color schema.  Set the SOLARIZED_THEME variable to one of
# these two values to choose.  If you don't specify, we'll assume you're
# using the "dark" variant.

case ${SOLARIZED_THEME:-dark} in
    light) bkg=white;;
    *)     bkg=black;;
esac

ZSH_THEME_GIT_PROMPT_PREFIX=" [%{%B%F{blue}%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{%f%k%b%K{${bkg}}%B%F{green}%}]"
ZSH_THEME_GIT_PROMPT_SUFFIX=""
ZSH_THEME_GIT_PROMPT_DIRTY=" %{%F{red}%}*%{%f%k%b%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# Brought over from kphoen's theme for now
ZSH_THEME_GIT_PROMPT_ADDED="%{%F{green}%} ✚"
ZSH_THEME_GIT_PROMPT_MODIFIED="%{%F{blue}%} ✹"
ZSH_THEME_GIT_PROMPT_DELETED="%{%F{red}%} ✖"
ZSH_THEME_GIT_PROMPT_RENAMED="%{%F{magenta}%} ➜"
ZSH_THEME_GIT_PROMPT_UNMERGED="%{%F{yellow}%} ═"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{%F{cyan}%} ✭"

# Main prompt
PROMPT='%{%f%k%b%}
%{%K{${bkg}}%B%F{green}%}%n%{%B%F{blue}%}@%{%B%F{cyan}%}%m%{%B%F{green}%} %{%b%F{yellow}%K{${bkg}}%}${PWD/#$HOME/~}%{%B%F{green}%}$(git_prompt_info)$(git_prompt_status)%{%f%k%b%K{${bkg}}%B%F{green}%}]%E%{%f%k%b%}
%{%K{${bkg}}%}$(_prompt_char)%{%K{${bkg}}%} %#%{%f%k%b%} '

# Right prompt - showing command number
RPROMPT='!%{%B%F{cyan}%}%!%{%f%k%b%}'
