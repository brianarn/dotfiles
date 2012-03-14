# .bashrc

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# grep options:
# Always color
export GREP_OPTIONS="--color=auto"

# Friendlier umask
umask 022

# Change prompt
export PS1='[\u@\h:\w]\$ '

# Fix X thru SSH
export XAUTHORITY=$HOME/.Xauthority

# Node libraries when using Homebrew
export NODE_PATH=/usr/local/lib/node_modules

### Aliases
# General aliases
alias more='less'
alias vi='vim'
alias wpdb='mysqldump --add-drop-table -c -u rtnet_wp -h db-wp.randomthink.net -p rtnet_wp > wp_db_`date +%Y%m%d_%H%M%S`.sql'
alias free='free -m'
alias serve='python -m SimpleHTTPServer 4000'

# Some convenient subversion aliases
alias ss='svn status --ignore-externals'
alias sadd='ss | grep ? | awk '\''{print $2}'\'' | xargs svn add'
alias srm='ss | grep ! | awk '\''{print $2}'\'' | xargs svn rm'

# OS-specific things
if [ `uname -s` == "Darwin" ]; then
	# Aliases
	alias ls='ls -FG'
	alias ll='ls -FlhG'
	alias la='ls -FlAGh'
	alias du1='du -hd1'
	# Use MacVim's Vim binary for more powersss
	alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
	alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'

	# Editor - with full path because git/svn was puking
	export EDITOR=/Applications/MacVim.app/Contents/MacOS/Vim
else
	# Aliases
	alias ls='ls -FG'
	alias ll='ls -FlhG'
	alias la='ls -FlAhG'
	alias du1='du -h --max-depth=1'

	# Editor woo
	export EDITOR=/usr/bin/vim
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

# Pull in some awesome Git completion
source ~/.git-completion.bash
source ~/.git-flow-completion.bash
