# ------------------------------------------------------------------------------
#          FILE:  kphoen.zsh-theme
#   DESCRIPTION:  oh-my-zsh theme file.
#        AUTHOR:  Kévin Gomez (geek63@gmail.com)
#       VERSION:  1.0.0
#    SCREENSHOT:
# ------------------------------------------------------------------------------

if [[ "$TERM" != "dumb" ]] && [[ "$DISABLE_LS_COLORS" != "true" ]]; then
    # Starting with an intentional newline
    PROMPT='
[%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[yellow]%}%m%{$reset_color%}:%{$fg[cyan]%}%~%{$reset_color%}$(git_prompt_info)]$(vi_mode_prompt_info)
[$(date +"$fg_bold[yellow]%H$reset_color:$fg_bold[yellow]%M$reset_color:$fg_bold[yellow]%S$reset_color")]$(git_prompt_status)%{$reset_color%}${return_code} %# '

    MODE_INDICATOR="%{$fg_bold[yellow]%} [% NORMAL]% %{$reset_color%}"

    ZSH_THEME_GIT_PROMPT_PREFIX="][%{$fg_bold[green]%}"
    ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # display exitcode when >0
    return_code="%(?.. %{$fg[red]%}%?%{$reset_color%})"

    #RPROMPT='${return_code}$(git_prompt_status)%{$reset_color%}'

    ZSH_THEME_GIT_PROMPT_ADDED="%{$fg[green]%} ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED="%{$fg[blue]%} ✹"
    ZSH_THEME_GIT_PROMPT_DELETED="%{$fg[red]%} ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED="%{$fg[magenta]%} ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED="%{$fg[yellow]%} ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[cyan]%} ✭"
else
    PROMPT='[%n@%m:%~$(git_prompt_info)]$(vi_mode_prompt_info)
[$(date +"%H:%M:%S")] ${return_code} %# '

    MODE_INDICATOR=" [% NORMAL]% "

    ZSH_THEME_GIT_PROMPT_PREFIX=" on"
    ZSH_THEME_GIT_PROMPT_SUFFIX=""
    ZSH_THEME_GIT_PROMPT_DIRTY=""
    ZSH_THEME_GIT_PROMPT_CLEAN=""

    # display exitcode when >0
    return_code="%(?..%? ↵)"

    RPROMPT='${return_code}$(git_prompt_status)'

    ZSH_THEME_GIT_PROMPT_ADDED=" ✚"
    ZSH_THEME_GIT_PROMPT_MODIFIED=" ✹"
    ZSH_THEME_GIT_PROMPT_DELETED=" ✖"
    ZSH_THEME_GIT_PROMPT_RENAMED=" ➜"
    ZSH_THEME_GIT_PROMPT_UNMERGED=" ═"
    ZSH_THEME_GIT_PROMPT_UNTRACKED=" ✭"
fi
