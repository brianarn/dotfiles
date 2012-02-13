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
PATH=~/.rbenv/shims:$PATH
export PATH
unset USERNAME

# rbenv
eval "$(rbenv init -)"
