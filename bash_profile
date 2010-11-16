# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs
PATH=/usr/local/mysql/bin:/usr/local/bin:/usr/local/sbin:$PATH
PATH=/usr/local/ant/bin:$PATH
PATH=/usr/local/android-sdk-mac_x86/tools:$PATH
PATH=/usr/local/phonegap-android/bin:$PATH
export PATH
unset USERNAME

# Pull in RVM if applicable
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm"
