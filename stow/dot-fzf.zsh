# Setup fzf
# ---------
if [[ ! "$PATH" == */home/brian/.dotfiles/external/fzf/bin* ]]; then
  export PATH="${PATH:+${PATH}:}/home/brian/.dotfiles/external/fzf/bin"
fi

# Auto-completion
# ---------------
[[ $- == *i* ]] && source "/home/brian/.dotfiles/external/fzf/shell/completion.zsh" 2> /dev/null

# Key bindings
# ------------
source "/home/brian/.dotfiles/external/fzf/shell/key-bindings.zsh"
