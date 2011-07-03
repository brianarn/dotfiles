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

# Set up editor and other useful environment things
# Without setting long path, some Vim plugins caused an
# exit status of 1, screwing up git/svn
export EDITOR=/usr/bin/vim

# Pull in some awesome Git completion
source ~/.git-completion.bash
source ~/.git-flow-completion.bash
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
export NODE_PATH=/usr/local/lib/node

### Aliases
# System variations
if [ $OSTYPE == "darwin10.0" ]; then
	alias ls='ls -FG'
	alias ll='ls -FlhG'
	alias la='ls -FlAGh'
	alias du1='du -hd1'
else
	alias ls='ls -F --color'
	alias ll='ls -Flh --color'
	alias la='ls -FlAh --color'
	alias du1='du -h --max-depth=1'
fi

# Other aliases
alias more='less'
alias vi='vim'
alias wpdb='mysqldump --add-drop-table -c -u rtnet_wp -h db-wp.randomthink.net -p rtnet_wp > wp_db_`date +%Y%m%d_%H%M%S`.sql'
alias free='free -m'
alias ss='svn status --ignore-externals'
alias serve='python -m SimpleHTTPServer 4000'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
