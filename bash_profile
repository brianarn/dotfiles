# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
export PATH=/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin:$PATH
unset USERNAME

# Pull in RVM if applicable
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
