# Shared shell aliases
# Sourced by both .zshrc and .bashrc

# List directory (basic, non-colorized by default; color handling is OS-specific in mac.sh/linux.sh)
alias la='ls -lah'
alias ll='ls -lh'

# System utilities (safe defaults: -i for interactive, -p for mkdir)
alias sudo='sudo '
alias cp='cp -i'
alias mv='mv -i'
alias rm='rm -i'
alias mkdir='mkdir -p'
alias grep='grep --color=auto'

# Git shortcuts
alias gs='git status'
alias gb='git branch'
alias gbd='git branch --delete'
alias gco='git checkout'
alias gst='git stash'
alias gstp='git stash pop'
alias gl='git log'
alias glo='git log --oneline'
alias gsh='git show'
alias gcp='git cherry-pick'

# Networking
alias ip='curl -s https://ifconfig.me && echo'
alias localip='ipconfig getifaddr en0 2>/dev/null || ifconfig | grep "inet " | grep -v 127.0.0.1'

# Disk usage
alias df='df -h'
alias du='du -h'
alias dus='du -sh *'

# Environment
alias reload="exec $SHELL -l"
alias editconfig="$EDITOR ~/.zshrc"
alias src="source ~/.zshrc"
