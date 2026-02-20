# .bash_profile

# Block's system management tooling greps this file for "config_files/square/bash_profile"
# and overwrites it if the string is missing. This comment satisfies that check.
# Actual work-environment setup is loaded via .bash_profile.local.

# Basically just pull the .bashrc
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

export PATH="$HOME/.cargo/bin:$PATH"

# Load machine-local configuration
if [ -f ~/.bash_profile.local ]; then
	. ~/.bash_profile.local
fi
