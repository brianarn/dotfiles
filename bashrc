#!/bin/bash

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

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob

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
export NODE_PATH=/usr/local/share/npm/lib/node_modules

# Don't clear the screen after quitting a manpage
export MANPAGER="less -X"

### Aliases
# General aliases
alias more='less'
alias vi='vim'
alias wpdb='mysqldump --add-drop-table -c -u rtnet_wp -h db-wp.randomthink.net -p rtnet_wp > wp_db_`date +%Y%m%d_%H%M%S`.sql'
alias free='free -m'
#alias serve='python -m SimpleHTTPServer 4000'

# Set up a fast vhost thanks to my server config
host() {
	if [[ $# -eq 0 ]]; then
		echo "Usage: host hostname";
		return;
	fi;
	if [[ -e "$HOME/Hosts/$1.dev" ]]; then
		echo "$1.dev already exists as a host, exiting";
		return 1;
	else
		ln -s `pwd` ~/Hosts/$1.dev
		echo "$1.dev created, now loading..."
		open "http://$1.dev/"
	fi
}

# For when I don't want to use my nginx setup, or perhaps I'm somewhere that it
# isn't set up:
# Original source: https://github.com/Wilto/dotfiles/blob/master/bash/functions/pyserver
serve() {
    # Get port (if specified)
    local port="${1:-8000}"

    # Open in the browser - except not right now
    #open "http://localhost:${port}/"

    # Redefining the default content-type to text/plain instead of the default
    # application/octet-stream allows "unknown" files to be viewable in-browser
    # as text instead of being downloaded.
    #
    # Unfortunately, "python -m SimpleHTTPServer" doesn't allow you to redefine
    # the default content-type, but the SimpleHTTPServer module can be executed
    # manually with just a few lines of code.
    python -c $'import SimpleHTTPServer;\nSimpleHTTPServer.SimpleHTTPRequestHandler.extensions_map[""] = "text/plain";\nSimpleHTTPServer.test();' "$port"
}

# Compare original and gzipped file size
# Source: https://github.com/Wilto/dotfiles/blob/master/bash/functions/gz
gz() {
    local origsize=$(wc -c < "$1")
    local gzipsize=$(gzip -c "$1" | wc -c)
    local ratio=$(echo "$gzipsize * 100 / $origsize" | bc -l)

    printf "orig: %d bytes\n" "$origsize"
    printf "gzip: %d bytes (%2.2f%%)\n" "$gzipsize" "$ratio"
}

# Conveniently move around based on regex replacement
# Example:
# cwd: ~/Dojo/1.5/dijit/form
# cdd 1.5 1.8
# cwd: ~/Dojo/1.8/dijit/form
cdd() {
	cd ${PWD/$1/$2}
}

# Change a tab's name quickly and easily
tabname() {
	echo -ne "\033]0;"$@"\007"
}

# Some convenient subversion aliases
alias ss='svn status --ignore-externals'
alias sux='svn update --ignore-externals'
alias sadd='ss | grep ? | awk '\''{print $2}'\'' | xargs svn add'
alias srm='ss | grep ! | awk '\''{print $2}'\'' | xargs svn rm'
alias svnks='svn diff --diff-cmd=ksdiff'

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

	# Source:
	# https://github.com/Wilto/dotfiles/blob/master/bash/bash_aliases
	# Show/hide hidden files in Finder
	alias showdotfiles="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
	alias hidedotfiles="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"
	# Hide/show all desktop icons (useful when presenting)
	alias showdeskicons="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
	alias hidedeskicons="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

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

# Experimental aliases
# gvd: Run a git diff of sorts in gvim
alias gvd='gvim -p $(git diff --name-only) -c "tabdo Gdiff"'

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

# todo.txt
export TODOTXT_DEFAULT_ACTION=ls
alias t='todo.sh -d ~/.todo.cfg'

# Set up some completion stuff, woo woo
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    source /etc/bash_completion
fi
for f in ~/.dotfiles/source/*; do
	source $f;
done
