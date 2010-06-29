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
export EDITOR=vim

# Friendlier umask
umask 022

# Change prompt
export PS1='[\u@\h:\w]\$ '

# Fix X thru SSH
export XAUTHORITY=$HOME/.Xauthority

### Aliases
# System commands
# The 'ls' aliases respond differently on a Mac
if [ $OSTYPE == "darwin10.0" ]; then
	alias ls='ls -FG'
	alias ll='ls -FlhG'
	alias la='ls -FlAGh'
else
	alias ls='ls -F --color'
	alias ll='ls -Flh --color'
	alias la='ls -FlAh --color'
fi

# Other aliases
alias more='less'
alias vi='vim'
alias du1='du -h --max-depth=1'
alias wpdb='mysqldump --add-drop-table -c -u rtnet_wp -h db-wp.randomthink.net -p rtnet_wp > wp_db_`date +%Y%m%d_%H%M%S`.sql'

# File copy
tortnet() { scp -r $* brianarn@randomthink.net:~/domains/randomthink.net/; }

# One-liners, for convenience
alias myps='ps aux | grep brian'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias free='free -m'

# Machines
alias rtnet='ssh brianarn@randomthink.net'
alias moons='ssh -X -l brian moons.cs.unm.edu'

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi
