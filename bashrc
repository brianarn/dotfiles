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
# Now done via sourcing, keeping this here for the moment
#export PS1='[\u@\h: \W$(__git_ps1 " (%s)")]\$ '

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
alias svnks='svn diff --diff-cmd=ksdiff-svnwrapper'

# OMG SYNTAX HIGHLIGHTED CAT
alias c='pygmentize -O style=monokai -f console256 -g'

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

# Was in my .bash_profile, moving over here for more convenient management
# User specific environment and startup programs
PATH=/usr/local/share/npm/bin:$PATH
PATH=/usr/local/bin:/usr/local/sbin:$PATH
PATH=/usr/local/ant/bin:$PATH
PATH=/usr/local/android-sdk-mac_x86/tools:$PATH
PATH=/usr/local/phonegap-android/bin:$PATH
PATH=/usr/local/mysql/bin:$PATH
PATH=~/.rbenv/shims:$PATH
export PATH

# Not sure why I was doing this, let's turn it off awhile
#unset USERNAME

# Run rbenv if we have it
hash rbenv 2> /dev/null && eval "$(rbenv init -)"

# If I have hub installed, alias it over git
hash hub 2> /dev/null && alias git='hub'

# Set up some completion stuff, woo woo
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi
for f in ~/.dotfiles/source/*; do
	source $f;
done
